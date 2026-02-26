import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';
import 'daos/customer_dao.dart';
import 'daos/job_dao.dart';
import 'daos/line_item_dao.dart';
import 'daos/reminder_dao.dart';
import 'daos/job_image_dao.dart';
import 'daos/settings_dao.dart';
import 'daos/material_template_dao.dart';
import 'daos/payment_dao.dart';
import 'daos/transaction_dao.dart';
import 'daos/period_dao.dart';

part 'database.g.dart';

/// Ana veritabanı provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

@DriftDatabase(
  tables: [
    Customers,
    Jobs,
    LineItems,
    Reminders,
    JobImages,
    AppSettings,
    MaterialTemplates,
    Payments,
    Transactions,
    BudgetPeriods,
  ],
  daos: [
    CustomerDao,
    JobDao,
    LineItemDao,
    ReminderDao,
    JobImageDao,
    SettingsDao,
    MaterialTemplateDao,
    PaymentDao,
    TransactionDao,
    PeriodDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Varsayılan ayarları oluştur
          await into(appSettings).insert(
            AppSettingsCompanion.insert(),
          );
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(reminders, reminders.isCompleted);
          }
          if (from < 3) {
            await m.addColumn(jobs, jobs.quotedPrice);
            await m.addColumn(jobs, jobs.depositAmount);
            await m.addColumn(jobs, jobs.collectedAmount);
            await m.createTable(payments);
          }
          if (from < 4) {
            await m.addColumn(jobs, jobs.customExpense);
          }
          if (from < 5) {
            await m.createTable(transactions);
          }
          if (from < 6) {
            await m.addColumn(reminders, reminders.soundType);
          }
          if (from < 7) {
            await m.createTable(budgetPeriods);
            await m.addColumn(transactions, transactions.periodId);
            await m.addColumn(payments, payments.periodId);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'usta360.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
