import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/theme/app_colors.dart';

class CustomerDetailScreen extends ConsumerWidget {
  final int customerId;
  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerDetailProvider(customerId));
    final customerJobsAsync = ref.watch(customerJobsProvider(customerId));
    final currencyFormat = NumberFormat.currency(locale: 'tr', symbol: '₺', decimalDigits: 0);

    return customerAsync.when(
      data: (customer) {
        if (customer == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const EmptyState(icon: Icons.error_outline, title: 'Müşteri bulunamadı'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(customer.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.push('/customer/${customer.id}/edit'),
              ),
              PopupMenuButton<String>(
                onSelected: (action) async {
                  if (action == 'delete') {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Müşteriyi Sil'),
                        content: const Text('Bu müşteri silinecek. Devam?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
                          TextButton(onPressed: () => Navigator.pop(ctx, true), style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('Sil')),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await ref.read(customerDaoProvider).softDeleteCustomer(customer.id);
                      ref.invalidate(customersProvider);
                      if (context.mounted) context.pop();
                    }
                  }
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'delete', child: Text('Sil', style: TextStyle(color: Colors.red))),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Müşteri bilgileri
              GlassCard(
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Text(customer.name[0].toUpperCase(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(customer.name, style: Theme.of(context).textTheme.titleMedium),
                            if (customer.phone != null) Text(customer.phone!, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ]),
                    if (customer.email != null) ...[const Divider(height: 24), _infoRow('E-posta', customer.email!)],
                    if (customer.address != null) ...[const Divider(height: 24), _infoRow('Adres', customer.address!)],
                    if (customer.notes != null && customer.notes!.isNotEmpty) ...[const Divider(height: 24), _infoRow('Notlar', customer.notes!)],
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Müşterinin işleri
              SectionHeader(
                title: '🔧 İşler',
                actionText: '+ Yeni İş',
                onAction: () => context.push('/job/new?customerId=$customerId'),
              ),
              customerJobsAsync.when(
                data: (jobs) {
                  if (jobs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Bu müşteriye ait iş yok.', style: TextStyle(color: Colors.grey)),
                    );
                  }

                  return Column(
                    children: jobs.map((job) => GlassCard(
                      onTap: () => context.push('/job/${job.id}'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(job.title, style: Theme.of(context).textTheme.titleSmall),
                                const SizedBox(height: 4),
                                Text(DateFormat('dd.MM.yyyy').format(job.createdAt), style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                          StatusBadge(status: job.status),
                          const SizedBox(width: 8),
                          Text(currencyFormat.format(job.totalSale), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    )).toList(),
                  );
                },
                loading: () => const LoadingWidget(),
                error: (e, _) => Text('Hata: $e'),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: LoadingWidget()),
      error: (e, _) => Scaffold(appBar: AppBar(), body: Center(child: Text('Hata: $e'))),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
