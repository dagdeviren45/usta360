import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'line_item_dao.g.dart';

@DriftAccessor(tables: [LineItems])
class LineItemDao extends DatabaseAccessor<AppDatabase>
    with _$LineItemDaoMixin {
  LineItemDao(super.db);

  /// İşe ait tüm kalemleri getir
  Future<List<LineItem>> getItemsByJob(int jobId) {
    return (select(lineItems)
          ..where((l) => l.jobId.equals(jobId))
          ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
        .get();
  }

  /// Türe göre kalemleri getir
  Future<List<LineItem>> getItemsByType(int jobId, String type) {
    return (select(lineItems)
          ..where((l) => l.jobId.equals(jobId) & l.type.equals(type))
          ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
        .get();
  }

  /// Kalem ekle
  Future<int> insertItem(LineItemsCompanion item) {
    return into(lineItems).insert(item);
  }

  /// Kalem güncelle
  Future<bool> updateItem(LineItem item) {
    return update(lineItems).replace(item);
  }

  /// Kalem sil
  Future<void> deleteItem(int id) {
    return (delete(lineItems)..where((l) => l.id.equals(id))).go();
  }

  /// İşe ait tüm kalemleri sil
  Future<void> deleteItemsByJob(int jobId) {
    return (delete(lineItems)..where((l) => l.jobId.equals(jobId))).go();
  }

  /// Kalemlerin sırasını güncelle
  Future<void> updateSortOrders(List<LineItem> items) async {
    await batch((batch) {
      for (int i = 0; i < items.length; i++) {
        batch.update(
          lineItems,
          LineItemsCompanion(sortOrder: Value(i)),
          where: (t) => t.id.equals(items[i].id),
        );
      }
    });
  }

  /// Stream olarak kalemleri izle
  Stream<List<LineItem>> watchItemsByJob(int jobId) {
    return (select(lineItems)
          ..where((l) => l.jobId.equals(jobId))
          ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
        .watch();
  }
}
