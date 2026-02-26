import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'job_dao.g.dart';

/// İş ile müşteri birlikte
class JobWithCustomer {
  final Job job;
  final Customer customer;
  JobWithCustomer({required this.job, required this.customer});
}

@DriftAccessor(tables: [Jobs, Customers, LineItems])
class JobDao extends DatabaseAccessor<AppDatabase> with _$JobDaoMixin {
  JobDao(super.db);

  /// Tüm aktif işleri (müşteri bilgisiyle) getir
  Future<List<JobWithCustomer>> getAllJobs() async {
    final query = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.isDeleted.equals(false))
      ..orderBy([OrderingTerm.desc(jobs.createdAt)]);

    final results = await query.get();
    return results.map((row) {
      return JobWithCustomer(
        job: row.readTable(jobs),
        customer: row.readTable(customers),
      );
    }).toList();
  }

  /// İş detayını getir
  Future<JobWithCustomer?> getJobById(int id) async {
    final query = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.id.equals(id));

    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return JobWithCustomer(
      job: result.readTable(jobs),
      customer: result.readTable(customers),
    );
  }

  /// Müşteriye ait işleri getir
  Future<List<Job>> getJobsByCustomer(int customerId) {
    return (select(jobs)
          ..where((j) =>
              j.customerId.equals(customerId) & j.isDeleted.equals(false))
          ..orderBy([(j) => OrderingTerm.desc(j.createdAt)]))
        .get();
  }

  /// Duruma göre işleri getir
  Future<List<JobWithCustomer>> getJobsByStatus(String status) async {
    final query = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.isDeleted.equals(false) & jobs.status.equals(status))
      ..orderBy([OrderingTerm.desc(jobs.createdAt)]);

    final results = await query.get();
    return results.map((row) {
      return JobWithCustomer(
        job: row.readTable(jobs),
        customer: row.readTable(customers),
      );
    }).toList();
  }

  /// İş ara
  Future<List<JobWithCustomer>> searchJobs(String query) async {
    final q = '%$query%';
    final jq = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.isDeleted.equals(false) &
          (jobs.title.like(q) |
              jobs.description.like(q) |
              customers.name.like(q)))
      ..orderBy([OrderingTerm.desc(jobs.createdAt)]);

    final results = await jq.get();
    return results.map((row) {
      return JobWithCustomer(
        job: row.readTable(jobs),
        customer: row.readTable(customers),
      );
    }).toList();
  }

  /// İş ekle
  Future<int> insertJob(JobsCompanion job) {
    return into(jobs).insert(job);
  }

  /// İş güncelle
  Future<bool> updateJob(Job job) {
    return update(jobs).replace(job);
  }

  Future<void> updateJobTotals(int jobId) async {
    final items = await (select(lineItems)
          ..where((l) => l.jobId.equals(jobId)))
        .get();

    double totalCost = 0;
    double totalSale = 0;

    for (final item in items) {
      totalCost += item.costPerUnit * item.quantity;
      totalSale += item.salePerUnit * item.quantity;
    }

    // İşin mevcut bilgilerini al (customExpense için)
    final job = await (select(jobs)..where((j) => j.id.equals(jobId))).getSingle();

    final totalProfit = totalSale - (totalCost + job.customExpense);
    final totalExp = totalCost + job.customExpense;
    final profitRate = totalExp > 0 ? (totalProfit / totalExp) * 100 : 0.0;

    await (update(jobs)..where((j) => j.id.equals(jobId))).write(
      JobsCompanion(
        totalCost: Value(totalCost),
        totalSale: Value(totalSale),
        profit: Value(totalProfit),
        profitRate: Value(profitRate),
      ),
    );
  }

  /// İşi sil (soft delete)
  Future<void> softDeleteJob(int id) {
    return (update(jobs)..where((j) => j.id.equals(id))).write(
      JobsCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(DateTime.now()),
      ),
    );
  }

  /// İşi kalıcı sil
  Future<void> permanentDeleteJob(int id) {
    return (delete(jobs)..where((j) => j.id.equals(id))).go();
  }

  /// Silinmiş işleri getir
  Future<List<JobWithCustomer>> getDeletedJobs() async {
    final query = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.isDeleted.equals(true))
      ..orderBy([OrderingTerm.desc(jobs.deletedAt)]);

    final results = await query.get();
    return results.map((row) {
      return JobWithCustomer(
        job: row.readTable(jobs),
        customer: row.readTable(customers),
      );
    }).toList();
  }

  /// Silinmiş işi geri yükle
  Future<void> restoreJob(int id) {
    return (update(jobs)..where((j) => j.id.equals(id))).write(
      const JobsCompanion(
        isDeleted: Value(false),
        deletedAt: Value(null),
      ),
    );
  }

  /// İş sayısı
  Future<int> getJobCount() async {
    final count = countAll();
    final query = selectOnly(jobs)
      ..where(jobs.isDeleted.equals(false))
      ..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Duruma göre iş sayısı
  Future<int> getJobCountByStatus(String status) async {
    final count = countAll();
    final query = selectOnly(jobs)
      ..where(jobs.isDeleted.equals(false) & jobs.status.equals(status))
      ..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Son N işi getir
  Future<List<JobWithCustomer>> getRecentJobs({int limit = 5}) async {
    final query = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.isDeleted.equals(false))
      ..orderBy([OrderingTerm.desc(jobs.createdAt)])
      ..limit(limit);

    final results = await query.get();
    return results.map((row) {
      return JobWithCustomer(
        job: row.readTable(jobs),
        customer: row.readTable(customers),
      );
    }).toList();
  }

  /// PDF gönderildi işaretle
  Future<void> markPdfSent(int jobId) {
    return (update(jobs)..where((j) => j.id.equals(jobId))).write(
      JobsCompanion(
        pdfSent: const Value(true),
        pdfSentAt: Value(DateTime.now()),
      ),
    );
  }

  /// Stream olarak işleri izle
  Stream<List<JobWithCustomer>> watchAllJobs() {
    final query = select(jobs).join([
      innerJoin(customers, customers.id.equalsExp(jobs.customerId)),
    ])
      ..where(jobs.isDeleted.equals(false))
      ..orderBy([OrderingTerm.desc(jobs.createdAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return JobWithCustomer(
          job: row.readTable(jobs),
          customer: row.readTable(customers),
        );
      }).toList();
    });
  }

  /// Belirli bir tarih aralığındaki istatistikleri getir
  Future<Map<String, double>> getStatsByDateRange(DateTime? startDate) async {
    var query = select(jobs)..where((j) => j.isDeleted.equals(false));
    if (startDate != null) {
      query = query..where((j) => j.createdAt.isBiggerOrEqualValue(startDate));
    }
    
    final results = await query.get();

    double totalCost = 0;
    double totalSale = 0;
    double totalProfit = 0;
    double totalCollection = 0;

    for (final job in results) {
      totalCost += (job.totalCost + job.customExpense);
      totalSale += job.totalSale;
      totalProfit += job.profit;
      totalCollection += job.collectedAmount; // Artık toplanan tutarı Payment tablosundan/Jobs field'dan alıyoruz
    }

    return {
      'totalCost': totalCost,
      'totalSale': totalSale,
      'totalProfit': totalProfit,
      'totalCollection': totalCollection,
    };
  }

  /// Toplam istatistikler
  Future<Map<String, double>> getTotalStats() => getStatsByDateRange(null);
}
