import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../database/daos/customer_dao.dart';
import '../database/daos/job_dao.dart';
import '../database/daos/line_item_dao.dart';
import '../database/daos/reminder_dao.dart';
import '../database/daos/job_image_dao.dart';
import '../database/daos/settings_dao.dart';
import '../database/daos/material_template_dao.dart';
import '../database/daos/payment_dao.dart';
import '../database/daos/transaction_dao.dart';
import '../database/daos/period_dao.dart';

// ─── DAO Providers ─────────────────────────────────────────

final customerDaoProvider = Provider<CustomerDao>((ref) {
  return ref.read(databaseProvider).customerDao;
});

final jobDaoProvider = Provider<JobDao>((ref) {
  return ref.read(databaseProvider).jobDao;
});

final lineItemDaoProvider = Provider<LineItemDao>((ref) {
  return ref.read(databaseProvider).lineItemDao;
});

final reminderDaoProvider = Provider<ReminderDao>((ref) {
  return ref.read(databaseProvider).reminderDao;
});

final jobImageDaoProvider = Provider<JobImageDao>((ref) {
  return ref.read(databaseProvider).jobImageDao;
});

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return ref.read(databaseProvider).settingsDao;
});

final materialTemplateDaoProvider = Provider<MaterialTemplateDao>((ref) {
  return ref.read(databaseProvider).materialTemplateDao;
});

final paymentDaoProvider = Provider<PaymentDao>((ref) {
  return ref.read(databaseProvider).paymentDao;
});

final transactionDaoProvider = Provider<TransactionDao>((ref) {
  return ref.read(databaseProvider).transactionDao;
});

final periodDaoProvider = Provider<PeriodDao>((ref) {
  return ref.read(databaseProvider).periodDao;
});

// ─── Data Providers (Stream/Future) ────────────────────────

/// Aktif Dönem
final activePeriodProvider = FutureProvider<BudgetPeriod>((ref) {
  return ref.read(periodDaoProvider).getOrCreateActivePeriod();
});

/// Tüm dönemler
final allPeriodsProvider = FutureProvider<List<BudgetPeriod>>((ref) {
  return ref.read(periodDaoProvider).getAllPeriods();
});

/// Tüm müşteriler (stream)
final customersProvider = StreamProvider<List<Customer>>((ref) {
  return ref.read(customerDaoProvider).watchAllCustomers();
});

/// Tüm işler (stream)
final jobsProvider = StreamProvider<List<JobWithCustomer>>((ref) {
  return ref.read(jobDaoProvider).watchAllJobs();
});

/// Son işler
final recentJobsProvider = FutureProvider<List<JobWithCustomer>>((ref) {
  return ref.read(jobDaoProvider).getRecentJobs(limit: 5);
});

/// İş sayısı
final jobCountProvider = FutureProvider<int>((ref) {
  return ref.read(jobDaoProvider).getJobCount();
});

/// Müşteri sayısı
final customerCountProvider = FutureProvider<int>((ref) {
  return ref.read(customerDaoProvider).getCustomerCount();
});

/// Durum bazlı iş sayıları
final jobStatusCountsProvider =
    FutureProvider<Map<String, int>>((ref) async {
  final dao = ref.read(jobDaoProvider);
  return {
    'draft': await dao.getJobCountByStatus('draft'),
    'active': await dao.getJobCountByStatus('active'),
    'pending': await dao.getJobCountByStatus('pending'),
    'completed': await dao.getJobCountByStatus('completed'),
    'cancelled': await dao.getJobCountByStatus('cancelled'),
  };
});

/// Genel işlemler
final transactionsProvider = FutureProvider<List<Transaction>>((ref) {
  return ref.read(transactionDaoProvider).getAllTransactions();
});

/// İşlem istatistikleri
final transactionStatsProvider = FutureProvider<Map<String, double>>((ref) {
  return ref.read(transactionDaoProvider).getTransactionStats();
});

/// Aktif Dönem Hareketleri
final activePeriodTransactionsProvider = FutureProvider<List<dynamic>>((ref) async {
  final activePeriod = await ref.watch(activePeriodProvider.future);
  final trans = await ref.read(transactionDaoProvider).getTransactionsByPeriod(activePeriod.id);
  final pays = await ref.read(paymentDaoProvider).getPaymentsByPeriod(activePeriod.id);

  final all = [...trans, ...pays];
  all.sort((a, b) {
    final dateA = a is Transaction ? a.date : (a as Payment).paymentDate;
    final dateB = b is Transaction ? b.date : (b as Payment).paymentDate;
    return dateB.compareTo(dateA);
  });
  return all;
});

/// Genel Bakiye
final generalBalanceProvider = FutureProvider<Map<String, double>>((ref) async {
  final activePeriod = await ref.watch(activePeriodProvider.future);
  final stats = await ref.read(periodDaoProvider).getPeriodStats(activePeriod.id);
  return stats;
});

/// Toplam istatistikler
final totalStatsProvider = FutureProvider<Map<String, double>>((ref) {
  return ref.read(jobDaoProvider).getTotalStats();
});

/// Haftalık istatistikler
final weeklyStatsProvider = FutureProvider<Map<String, double>>((ref) {
  final start = DateTime.now().subtract(const Duration(days: 7));
  return ref.read(jobDaoProvider).getStatsByDateRange(start);
});

/// Aylık istatistikler
final monthlyStatsProvider = FutureProvider<Map<String, double>>((ref) {
  final start = DateTime.now().subtract(const Duration(days: 30));
  return ref.read(jobDaoProvider).getStatsByDateRange(start);
});

/// Yıllık istatistikler
final yearlyStatsProvider = FutureProvider<Map<String, double>>((ref) {
  final start = DateTime.now().subtract(const Duration(days: 365));
  return ref.read(jobDaoProvider).getStatsByDateRange(start);
});

/// Yaklaşan hatırlatıcılar (stream)
final upcomingRemindersProvider = StreamProvider<List<Reminder>>((ref) {
  return ref.read(reminderDaoProvider).watchUpcomingReminders();
});

/// Bugünkü hatırlatıcılar
final todayRemindersProvider = FutureProvider<List<Reminder>>((ref) {
  return ref.read(reminderDaoProvider).getTodayReminders();
});

/// Ayarlar (stream)
final settingsProvider = StreamProvider<AppSetting>((ref) {
  return ref.read(settingsDaoProvider).watchSettings();
});

// ─── Job Detail Providers ──────────────────────────────────

/// Belirli bir iş detayı
final jobDetailProvider = FutureProvider.family<JobWithCustomer?, int>((ref, id) {
  return ref.read(jobDaoProvider).getJobById(id);
});

/// İşe ait kalemler (stream)
final jobLineItemsProvider = StreamProvider.family<List<LineItem>, int>((ref, jobId) {
  return ref.read(lineItemDaoProvider).watchItemsByJob(jobId);
});

/// İşe ait fotoğraflar (stream)
final jobImagesProvider = StreamProvider.family<List<JobImage>, int>((ref, jobId) {
  return ref.read(jobImageDaoProvider).watchImagesByJob(jobId);
});

/// İşe ait hatırlatıcılar
final jobRemindersProvider = FutureProvider.family<List<Reminder>, int>((ref, jobId) {
  return ref.read(reminderDaoProvider).getRemindersByJob(jobId);
});

/// İşe ait ödemeler (stream)
final jobPaymentsProvider = StreamProvider.family<List<Payment>, int>((ref, jobId) {
  return ref.read(paymentDaoProvider).watchPaymentsByJob(jobId);
});

/// Müşterinin ödeme istatistikleri
final customerPaymentStatsProvider = FutureProvider.family<Map<String, double>, int>((ref, customerId) {
  return ref.read(paymentDaoProvider).getCustomerPaymentStats(customerId);
});

// ─── Customer Detail Providers ─────────────────────────────

/// Belirli bir müşteri detayı
final customerDetailProvider = FutureProvider.family<Customer?, int>((ref, id) {
  return ref.read(customerDaoProvider).getCustomerById(id);
});

/// Müşterinin işleri
final customerJobsProvider = FutureProvider.family<List<Job>, int>((ref, customerId) {
  return ref.read(jobDaoProvider).getJobsByCustomer(customerId);
});

// ─── Search Providers ──────────────────────────────────────

/// İş arama
final jobSearchProvider =
    FutureProvider.family<List<JobWithCustomer>, String>((ref, query) {
  if (query.isEmpty) return ref.read(jobDaoProvider).getAllJobs();
  return ref.read(jobDaoProvider).searchJobs(query);
});

/// Müşteri arama
final customerSearchProvider =
    FutureProvider.family<List<Customer>, String>((ref, query) {
  if (query.isEmpty) return ref.read(customerDaoProvider).getAllCustomers();
  return ref.read(customerDaoProvider).searchCustomers(query);
});
