import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'customer_dao.g.dart';

@DriftAccessor(tables: [Customers, Jobs])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.db);

  /// Tüm aktif müşterileri getir (silinmemiş)
  Future<List<Customer>> getAllCustomers() {
    return (select(customers)
          ..where((c) => c.isDeleted.equals(false))
          ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]))
        .get();
  }

  /// Müşteriyi id ile getir
  Future<Customer?> getCustomerById(int id) {
    return (select(customers)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Müşteri ara (ad, telefon, email)
  Future<List<Customer>> searchCustomers(String query) {
    final q = '%$query%';
    return (select(customers)
          ..where((c) =>
              c.isDeleted.equals(false) &
              (c.name.like(q) | c.phone.like(q) | c.email.like(q)))
          ..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .get();
  }

  /// Etikete göre müşteri filtrele
  Future<List<Customer>> getCustomersByTag(String tag) {
    return (select(customers)
          ..where((c) =>
              c.isDeleted.equals(false) & c.tags.like('%"$tag"%')))
        .get();
  }

  /// Müşteri ekle
  Future<int> insertCustomer(CustomersCompanion customer) {
    return into(customers).insert(customer);
  }

  /// Müşteri güncelle
  Future<bool> updateCustomer(Customer customer) {
    return update(customers).replace(customer.copyWith(
      updatedAt: DateTime.now(),
    ));
  }

  /// Müşteriyi sil (soft delete)
  Future<void> softDeleteCustomer(int id) {
    return (update(customers)..where((c) => c.id.equals(id))).write(
      CustomersCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Müşteriyi kalıcı sil
  Future<void> permanentDeleteCustomer(int id) {
    return (delete(customers)..where((c) => c.id.equals(id))).go();
  }

  /// Silinmiş müşterileri getir (çöp kutusu)
  Future<List<Customer>> getDeletedCustomers() {
    return (select(customers)
          ..where((c) => c.isDeleted.equals(true))
          ..orderBy([(c) => OrderingTerm.desc(c.deletedAt)]))
        .get();
  }

  /// Silinmiş müşteriyi geri yükle
  Future<void> restoreCustomer(int id) {
    return (update(customers)..where((c) => c.id.equals(id))).write(
      const CustomersCompanion(
        isDeleted: Value(false),
        deletedAt: Value(null),
      ),
    );
  }

  /// Müşteri sayısı
  Future<int> getCustomerCount() async {
    final count = countAll();
    final query = selectOnly(customers)
      ..where(customers.isDeleted.equals(false))
      ..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Müşterinin iş sayısı
  Future<int> getJobCountForCustomer(int customerId) async {
    final count = countAll();
    final query = selectOnly(jobs)
      ..where(jobs.customerId.equals(customerId) &
          jobs.isDeleted.equals(false))
      ..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Tüm etiketleri getir
  Future<List<String>> getAllTags() async {
    final results = await (select(customers)
          ..where((c) => c.isDeleted.equals(false)))
        .get();
    final tags = <String>{};
    for (final customer in results) {
      // Tags JSON array olarak saklanıyor
      final tagList = customer.tags;
      if (tagList.isNotEmpty && tagList != '[]') {
        final cleaned = tagList
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll('"', '');
        for (final tag in cleaned.split(',')) {
          final trimmed = tag.trim();
          if (trimmed.isNotEmpty) tags.add(trimmed);
        }
      }
    }
    return tags.toList()..sort();
  }

  /// Stream olarak müşteri değişikliklerini izle
  Stream<List<Customer>> watchAllCustomers() {
    return (select(customers)
          ..where((c) => c.isDeleted.equals(false))
          ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]))
        .watch();
  }
}
