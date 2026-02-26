import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'period_dao.g.dart';

@DriftAccessor(tables: [BudgetPeriods, Transactions, Payments, Jobs])
class PeriodDao extends DatabaseAccessor<AppDatabase> with _$PeriodDaoMixin {
  PeriodDao(super.db);

  /// Aktif dönemi getir (yoksa oluştur)
  Future<BudgetPeriod> getOrCreateActivePeriod() async {
    final active = await (select(budgetPeriods)..where((p) => p.isActive.equals(true))).getSingleOrNull();
    if (active != null) return active;

    // Yeni dönem oluştur (Şu anki ay)
    final now = DateTime.now();
    final name = '${_getMonthName(now.month)} ${now.year}';
    
    final id = await into(budgetPeriods).insert(BudgetPeriodsCompanion.insert(
      name: name,
      startDate: now,
      isActive: const Value(true),
    ));

    return (select(budgetPeriods)..where((p) => p.id.equals(id))).getSingle();
  }

  /// Tüm dönemleri getir
  Future<List<BudgetPeriod>> getAllPeriods() {
    return (select(budgetPeriods)..orderBy([(p) => OrderingTerm.desc(p.startDate)])).get();
  }

  /// Dönemi sonlandır
  Future<void> closePeriod(int periodId, double closingBalance) async {
    await (update(budgetPeriods)..where((p) => p.id.equals(periodId))).write(
      BudgetPeriodsCompanion(
        isActive: const Value(false),
        endDate: Value(DateTime.now()),
        closingBalance: Value(closingBalance),
      ),
    );
  }

  /// Döneme ait verileri sıfırla (dikkatli kullanım!)
  Future<void> resetPeriod(int periodId) async {
    await (delete(transactions)..where((t) => t.periodId.equals(periodId))).go();
    await (update(payments)..where((p) => p.periodId.equals(periodId))).write(
      const PaymentsCompanion(periodId: Value(null)),
    );
  }

  /// Dönem istatistiklerini hesapla
  Future<Map<String, double>> getPeriodStats(int periodId) async {
    // 1. Genel İşlemler (Gelir/Gider)
    final trans = await (select(transactions)..where((t) => t.periodId.equals(periodId))).get();
    double income = 0;
    double expense = 0;

    for (final t in trans) {
      if (t.type == 'income') income += t.amount;
      else expense += t.amount;
    }

    // 2. İş Ödemeleri (Tahsilatlar)
    final pays = await (select(payments)..where((p) => p.periodId.equals(periodId))).get();
    for (final p in pays) {
      income += p.amount;
    }

    // 3. Alacaklar (Dönem içindeki işlerin kalan bakiyesi)
    // Bu kısım yoruma açık, şimdilik sadece kesinleşmişleri sayıyoruz.

    return {
      'income': income,
      'expense': expense,
      'balance': income - expense,
    };
  }

  String _getMonthName(int month) {
    const names = ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return names[month - 1];
  }
}
