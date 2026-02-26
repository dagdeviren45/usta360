import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  TransactionDao(super.db);

  /// Tüm işlemleri getir
  Future<List<Transaction>> getAllTransactions() {
    return (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
  }

  /// Belirli bir döneme ait işlemleri getir
  Future<List<Transaction>> getTransactionsByPeriod(int periodId) {
    return (select(transactions)
          ..where((t) => t.periodId.equals(periodId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  /// Belirli bir tarih aralığındaki işlemleri getir
  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end) {
    return (select(transactions)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  /// İşlem ekle (Aktif dönem otomatik atanır)
  Future<int> insertTransaction(TransactionsCompanion entry) async {
    // Aktif dönemi bul veya yoksa oluştur
    final active = await db.periodDao.getOrCreateActivePeriod();
    entry = entry.copyWith(periodId: Value(active.id));
    
    return into(transactions).insert(entry);
  }

  /// İşlem sil
  Future<int> deleteTransaction(int id) {
    return (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  /// İşlem güncelle
  Future<bool> updateTransaction(Transaction transaction) {
    return update(transactions).replace(transaction);
  }

  /// Toplam gelir ve gideri hesapla
  Future<Map<String, double>> getTransactionStats() async {
    final results = await select(transactions).get();
    double income = 0;
    double expense = 0;

    for (final t in results) {
      if (t.type == 'income') {
        income += t.amount;
      } else {
        expense += t.amount;
      }
    }

    return {
      'income': income,
      'expense': expense,
      'balance': income - expense,
    };
  }
}
