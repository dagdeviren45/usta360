import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/database/database.dart';

class LedgerScreen extends ConsumerWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(generalBalanceProvider);
    final transactionsAsync = ref.watch(activePeriodTransactionsProvider);
    final currencyFormat = NumberFormat.currency(locale: 'tr', symbol: '₺', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(title: const Text('🏦 Kasa Defteri')),
      body: Column(
        children: [
          // Bakiye özeti
          balanceAsync.when(
            data: (v) => Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('Net Bakiye', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(
                    currencyFormat.format(v['balance'] ?? 0),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _balanceSummary('Gelir', currencyFormat.format(v['income'] ?? 0), Colors.greenAccent),
                      Container(width: 1, height: 30, color: Colors.white24),
                      _balanceSummary('Gider', currencyFormat.format(v['expense'] ?? 0), Colors.redAccent),
                    ],
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox(height: 140, child: LoadingWidget()),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // İşlem listesi
          Expanded(
            child: transactionsAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return const EmptyState(
                    icon: Icons.receipt_long,
                    title: 'Henüz işlem yok',
                    subtitle: 'Gelir veya gider ekleyerek başlayın',
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    if (item is Transaction) {
                      final isIncome = item.type == 'income';
                      return GlassCard(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (isIncome ? AppColors.success : AppColors.error).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                                color: isIncome ? AppColors.success : AppColors.error,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Text(
                                    DateFormat('dd.MM.yyyy').format(item.date),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${isIncome ? '+' : '-'}${currencyFormat.format(item.amount)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isIncome ? AppColors.success : AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (item is Payment) {
                      return GlassCard(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.payment, color: AppColors.accent, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.type == 'deposit' ? 'Kapora' : 'İş Ödemesi', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Text(
                                    DateFormat('dd.MM.yyyy').format(item.paymentDate),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '+${currencyFormat.format(item.amount)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.success),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                );
              },
              loading: () => const LoadingWidget(),
              error: (e, _) => Center(child: Text('Hata: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceSummary(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
