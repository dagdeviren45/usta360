import 'dart:io';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/database/database.dart';
import '../../core/database/daos/job_dao.dart';
import '../../core/services/notification_service.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.currency(
      locale: 'tr', symbol: '₺', decimalDigits: 0,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Consumer(
                builder: (context, ref, child) {
                  final settingsAsync = ref.watch(settingsProvider);
                  return settingsAsync.when(
                    data: (settings) => _buildAppBarTitle(context, settings),
                    loading: () => _buildAppBarTitle(context, null),
                    error: (_, __) => _buildAppBarTitle(context, null),
                  );
                },
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: IconButton.filled(
                  onPressed: () => context.push('/job/new'),
                  icon: const Icon(Icons.add, size: 22),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildGeneralBalanceSection(context, ref, currencyFormat),
                const SizedBox(height: 16),
                _buildStatCards(context, ref, currencyFormat),
                const SizedBox(height: 16),
                _buildTodayReminders(context, ref),
                const SizedBox(height: 8),
                _buildRecentJobs(context, ref, currencyFormat),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle(BuildContext context, dynamic settings) {
    final companyName = settings?.companyName;

    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.handyman, color: AppColors.primary, size: 28),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              companyName ?? 'Usta360 Pro',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              _getGreeting(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) return 'İyi geceler 🌙';
    if (hour < 12) return 'Günaydın ☀️';
    if (hour < 18) return 'İyi günler 🌤️';
    return 'İyi akşamlar 🌙';
  }

  Widget _buildGeneralBalanceSection(BuildContext context, WidgetRef ref, NumberFormat fmt) {
    final balanceAsync = ref.watch(generalBalanceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          balanceAsync.when(
            data: (v) => GlassCard(
              margin: EdgeInsets.zero,
              borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _balanceItem(context, '📈 Toplam Alacak', fmt.format(v['income'] ?? 0), AppColors.success),
                      Container(width: 1, height: 40, color: Theme.of(context).dividerColor),
                      _balanceItem(context, '📉 Toplam Gider', fmt.format(v['expense'] ?? 0), AppColors.error),
                    ],
                  ),
                  Divider(height: 32, color: Theme.of(context).dividerColor),
                  InkWell(
                    onTap: () => context.push('/ledger'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('🏦 Net Bakiye', style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        )),
                        Row(
                          children: [
                            Text(fmt.format(v['balance'] ?? 0),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: (v['balance'] ?? 0) >= 0 ? AppColors.success : AppColors.error,
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox(height: 120, child: LoadingWidget()),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _quickActionButton(context, ref, 'Gelir Ekle', Icons.add_chart, Colors.green,
                  () => _showTransactionSheet(context, ref, 'income')),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _quickActionButton(context, ref, 'Gider Ekle', Icons.remove_circle_outline, Colors.redAccent,
                  () => _showTransactionSheet(context, ref, 'expense')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _balanceItem(BuildContext context, String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _quickActionButton(BuildContext context, WidgetRef ref, String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        side: BorderSide(color: color.withOpacity(0.3)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _showTransactionSheet(BuildContext context, WidgetRef ref, String type) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 24, right: 24, top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type == 'income' ? '💰 Genel Gelir Ekle' : '💸 Genel Gider Ekle',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('İşlerden bağımsız, genel masraf veya gelir girişi.', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 24),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Tutar (₺)', suffixText: '₺'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final amount = double.tryParse(amountController.text) ?? 0;
                  if (amount > 0 && titleController.text.isNotEmpty) {
                    await ref.read(transactionDaoProvider).insertTransaction(
                      TransactionsCompanion.insert(
                        title: titleController.text.trim(),
                        amount: amount,
                        type: Value(type),
                        date: Value(DateTime.now()),
                      ),
                    );
                    ref.invalidate(generalBalanceProvider);
                    ref.invalidate(transactionStatsProvider);
                    if (ctx.mounted) Navigator.pop(ctx);
                  }
                },
                child: const Text('Kaydet'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context, WidgetRef ref, NumberFormat fmt) {
    final PageController controller = PageController(viewportFraction: 0.92);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('📊 Finansal Raporlar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 180,
          child: PageView(
            controller: controller,
            padEnds: false,
            children: [
              _buildReportCard(context, ref, fmt, 'Genel Durum', 'Tüm Zamanlar', totalStatsProvider),
              _buildReportCard(context, ref, fmt, 'Bu Ay', 'Son 30 Gün', monthlyStatsProvider),
              _buildReportCard(context, ref, fmt, 'Bu Yıl', 'Son 12 Ay', yearlyStatsProvider),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(BuildContext context, WidgetRef ref, NumberFormat fmt, String title, String subtitle, FutureProvider<Map<String, double>> provider) {
    final stats = ref.watch(provider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      margin: const EdgeInsets.only(right: 8, left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(subtitle, style: Theme.of(context).textTheme.labelSmall),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('💰 Toplam Satış', style: Theme.of(context).textTheme.bodySmall),
                    stats.when(
                      data: (v) => Text(fmt.format(v['totalSale'] ?? 0), style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold, fontSize: 16,
                      )),
                      loading: () => const Text('...'),
                      error: (_, __) => const Text('-'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('✅ Tahsil Edilen', style: Theme.of(context).textTheme.bodySmall),
                    stats.when(
                      data: (v) => Text(fmt.format(v['totalCollection'] ?? 0), style: TextStyle(
                        color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 16,
                      )),
                      loading: () => const Text('...'),
                      error: (_, __) => const Text('-'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('📈 Toplam Kâr: ', style: Theme.of(context).textTheme.bodySmall),
              stats.when(
                data: (v) => Text(fmt.format(v['totalProfit'] ?? 0), style: TextStyle(
                  color: isDark ? Colors.orangeAccent : Colors.orange.shade800,
                  fontWeight: FontWeight.w600, fontSize: 12,
                )),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayReminders(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(todayRemindersProvider);

    return remindersAsync.when(
      data: (reminders) {
        if (reminders.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: '📅 Hatırlatıcılar'),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 8),
                    child: GlassCard(
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Container(
                            width: 3, height: 40,
                            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(2)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reminder.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13), maxLines: 1),
                                if (reminder.description != null && reminder.description!.isNotEmpty)
                                  Text(reminder.description!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11), maxLines: 1),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.check_circle_outline, size: 20, color: Colors.greenAccent),
                            onPressed: () async {
                              await ref.read(reminderDaoProvider).markAsCompleted(reminder.id, true);
                              await ref.read(notificationServiceProvider).cancelNotification(reminder.notificationId);
                              ref.invalidate(todayRemindersProvider);
                              ref.invalidate(upcomingRemindersProvider);
                            },
                          ),
                          Text(DateFormat('HH:mm').format(reminder.scheduledAt),
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.accent)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildRecentJobs(BuildContext context, WidgetRef ref, NumberFormat currencyFormat) {
    final recentJobs = ref.watch(recentJobsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: '🔧 Son İşler',
          actionText: 'Tümünü Gör',
          onAction: () => context.go('/jobs'),
        ),
        recentJobs.when(
          data: (jobs) {
            if (jobs.isEmpty) {
              return const EmptyState(
                icon: Icons.work_off,
                title: 'Henüz iş eklenmemiş',
                subtitle: 'İlk işinizi eklemek için + butonuna dokunun',
              );
            }

            return Column(
              children: jobs.map((jc) {
                return _JobCard(
                  jobWithCustomer: jc,
                  currencyFormat: currencyFormat,
                  onTap: () => context.push('/job/${jc.job.id}'),
                );
              }).toList(),
            );
          },
          loading: () => const LoadingWidget(),
          error: (e, _) => Center(child: Text('Hata: $e')),
        ),
      ],
    );
  }
}

class _JobCard extends StatelessWidget {
  final JobWithCustomer jobWithCustomer;
  final NumberFormat currencyFormat;
  final VoidCallback? onTap;

  const _JobCard({required this.jobWithCustomer, required this.currencyFormat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final job = jobWithCustomer.job;
    final customer = jobWithCustomer.customer;

    return GlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.title, style: Theme.of(context).textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                        const SizedBox(width: 4),
                        Text(customer.name, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              StatusBadge(status: job.status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 13, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
              const SizedBox(width: 4),
              Text(DateFormat('dd MMM yyyy', 'tr').format(job.createdAt), style: Theme.of(context).textTheme.labelSmall),
              const Spacer(),
              Text(
                currencyFormat.format(job.quotedPrice > 0 ? job.quotedPrice : job.totalSale),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
