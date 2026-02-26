import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'reminder_dao.g.dart';

@DriftAccessor(tables: [Reminders, Jobs])
class ReminderDao extends DatabaseAccessor<AppDatabase>
    with _$ReminderDaoMixin {
  ReminderDao(super.db);

  /// Tüm hatırlatıcıları getir
  Future<List<Reminder>> getAllReminders() {
    return (select(reminders)
          ..where((r) => r.isCompleted.equals(false))
          ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
        .get();
  }

  /// İşe ait hatırlatıcılar
  Future<List<Reminder>> getRemindersByJob(int jobId) {
    return (select(reminders)
          ..where((r) => r.jobId.equals(jobId))
          ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
        .get();
  }

  /// Yaklaşan hatırlatıcılar (gelecekteki aktif olanlar)
  Future<List<Reminder>> getUpcomingReminders({int limit = 10}) {
    return (select(reminders)
          ..where((r) =>
              r.enabled.equals(true) &
              r.isCompleted.equals(false) &
              r.scheduledAt.isBiggerThanValue(DateTime.now()))
          ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)])
          ..limit(limit))
        .get();
  }

  /// Bugünkü hatırlatıcılar
  Future<List<Reminder>> getTodayReminders() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(reminders)
          ..where((r) =>
              r.isCompleted.equals(false) &
              r.scheduledAt.isBiggerOrEqualValue(startOfDay) &
              r.scheduledAt.isSmallerThanValue(endOfDay))
          ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)]))
        .get();
  }

  /// Hatırlatıcı ekle
  Future<int> insertReminder(RemindersCompanion reminder) {
    return into(reminders).insert(reminder);
  }

  /// Hatırlatıcı güncelle
  Future<bool> updateReminder(Reminder reminder) {
    return update(reminders).replace(reminder);
  }

  /// Hatırlatıcı sil
  Future<void> deleteReminder(int id) {
    return (delete(reminders)..where((r) => r.id.equals(id))).go();
  }

  /// İşe ait tüm hatırlatıcıları sil
  Future<void> deleteRemindersByJob(int jobId) {
    return (delete(reminders)..where((r) => r.jobId.equals(jobId))).go();
  }

  /// Hatırlatıcıyı aktif/pasif yap
  Future<void> toggleReminder(int id, bool enabled) {
    return (update(reminders)..where((r) => r.id.equals(id))).write(
      RemindersCompanion(enabled: Value(enabled)),
    );
  }

  /// Tüm aktif hatırlatıcıları getir (reboot sonrası reschedule için)
  Future<List<Reminder>> getAllActiveReminders() {
    return (select(reminders)
          ..where((r) =>
              r.enabled.equals(true) &
              r.isCompleted.equals(false) &
              r.scheduledAt.isBiggerThanValue(DateTime.now())))
        .get();
  }

  /// Stream olarak yaklaşan hatırlatıcıları izle
  Stream<List<Reminder>> watchUpcomingReminders() {
    return (select(reminders)
          ..where((r) =>
              r.enabled.equals(true) &
              r.isCompleted.equals(false) &
              r.scheduledAt.isBiggerThanValue(DateTime.now()))
          ..orderBy([(r) => OrderingTerm.asc(r.scheduledAt)])
          ..limit(10))
        .watch();
  }

  /// Hatırlatıcıyı tamamlandı olarak işaretle
  Future<void> markAsCompleted(int id, bool completed) {
    return (update(reminders)..where((r) => r.id.equals(id))).write(
      RemindersCompanion(isCompleted: Value(completed)),
    );
  }

  /// Eski ve tamamlanmış hatırlatıcıları temizle
  /// 1. Tamamlanmış olanlar hemen silinebilir (opsiyonel)
  /// 2. Üzerinden 1 gün geçen ve tekrar kuralı olmayanlar silinsin
  Future<void> cleanupOldReminders() async {
    final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
    
    // Geçmiş ve Tekrarlanmayanları Sil
    await (delete(reminders)
      ..where((r) => 
        r.scheduledAt.isSmallerThanValue(oneDayAgo) & 
        r.repeatRule.isNull()
      )).go();
      
    // Tamamlanmışları da sil (Kullanıcı talebi: onaylandıktan hemen silinsin)
    await (delete(reminders)..where((r) => r.isCompleted.equals(true))).go();
  }
}
