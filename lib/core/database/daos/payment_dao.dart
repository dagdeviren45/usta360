import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'payment_dao.g.dart';

@DriftAccessor(tables: [Payments, Jobs])
class PaymentDao extends DatabaseAccessor<AppDatabase>
    with _$PaymentDaoMixin {
  PaymentDao(super.db);

  /// İşe ait ödemeleri getir
  Future<List<Payment>> getPaymentsByJob(int jobId) {
    return (select(payments)
          ..where((p) => p.jobId.equals(jobId))
          ..orderBy([(p) => OrderingTerm.desc(p.paymentDate)]))
        .get();
  }

  /// İşe ait ödemeleri stream olarak izle
  Stream<List<Payment>> watchPaymentsByJob(int jobId) {
    return (select(payments)
          ..where((p) => p.jobId.equals(jobId))
          ..orderBy([(p) => OrderingTerm.desc(p.paymentDate)]))
        .watch();
  }

  /// Belirli bir döneme ait ödemeleri getir
  Future<List<Payment>> getPaymentsByPeriod(int periodId) {
    return (select(payments)
          ..where((p) => p.periodId.equals(periodId))
          ..orderBy([(p) => OrderingTerm.desc(p.paymentDate)]))
        .get();
  }

  /// Ödeme ekle ve iş toplamlarını güncelle (Aktif dönem otomatik atanır)
  Future<int> insertPayment(PaymentsCompanion payment) async {
    // Aktif dönemi bul veya yoksa oluştur
    final active = await db.periodDao.getOrCreateActivePeriod();
    payment = payment.copyWith(periodId: Value(active.id));

    final id = await into(payments).insert(payment);
    // İşin toplam tahsilat tutarını güncelle
    await _updateJobCollected(payment.jobId.value);
    return id;
  }

  /// Ödeme sil ve iş toplamlarını güncelle
  Future<void> deletePayment(int paymentId) async {
    final payment = await (select(payments)..where((p) => p.id.equals(paymentId))).getSingleOrNull();
    if (payment != null) {
      await (delete(payments)..where((p) => p.id.equals(paymentId))).go();
      await _updateJobCollected(payment.jobId);
    }
  }

  /// İşe ait toplam tahsilatı hesapla ve güncelle
  Future<void> _updateJobCollected(int jobId) async {
    final jobPayments = await getPaymentsByJob(jobId);
    double totalCollected = 0;
    double depositTotal = 0;
    for (final p in jobPayments) {
      if (p.type == 'refund') {
        totalCollected -= p.amount;
      } else {
        totalCollected += p.amount;
      }
      if (p.type == 'deposit') {
        depositTotal += p.amount;
      }
    }
    await (update(jobs)..where((j) => j.id.equals(jobId))).write(
      JobsCompanion(
        collectedAmount: Value(totalCollected),
        depositAmount: Value(depositTotal),
      ),
    );
  }

  /// Müşterinin toplam ödeme istatistiklerini getir
  Future<Map<String, double>> getCustomerPaymentStats(int customerId) async {
    // Müşterinin işlerini al
    final customerJobs = await (select(jobs)
          ..where((j) => j.customerId.equals(customerId) & j.isDeleted.equals(false)))
        .get();

    double totalQuoted = 0;
    double totalCollected = 0;
    double totalDeposit = 0;
    double totalRemaining = 0;

    for (final job in customerJobs) {
      // İşin toplam tutarı: quotedPrice varsa onu kullan, yoksa totalSale
      final jobTotal = job.quotedPrice > 0 ? job.quotedPrice : job.totalSale;
      totalQuoted += jobTotal;
      totalCollected += job.collectedAmount;
      totalDeposit += job.depositAmount;
      totalRemaining += (jobTotal - job.collectedAmount).clamp(0, double.infinity);
    }

    return {
      'totalQuoted': totalQuoted,
      'totalCollected': totalCollected,
      'totalDeposit': totalDeposit,
      'totalRemaining': totalRemaining,
    };
  }

  /// Son ödemeleri getir (tüm işlerden)
  Future<List<Payment>> getRecentPayments({int limit = 10}) {
    return (select(payments)
          ..orderBy([(p) => OrderingTerm.desc(p.paymentDate)])
          ..limit(limit))
        .get();
  }
}
