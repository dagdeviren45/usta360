import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/database/database.dart';

final _customerSearchQueryProvider = StateProvider<String>((ref) => '');

class CustomersListScreen extends ConsumerWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(_customerSearchQueryProvider);
    final customersAsync = searchQuery.isEmpty
        ? ref.watch(customersProvider)
        : ref.watch(customerSearchProvider(searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: const Text('👥 Müşteriler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context, ref),
          ),
        ],
      ),
      body: customersAsync.when(
        data: (customers) {
          if (customers.isEmpty) {
            return EmptyState(
              icon: Icons.people_outline,
              title: 'Henüz müşteri eklenmemiş',
              subtitle: 'İlk müşterinizi ekleyin',
              buttonText: '+ Yeni Müşteri',
              onButtonPressed: () => context.push('/customer/new'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final c = customers[index];
              return GlassCard(
                onTap: () => context.push('/customer/${c.id}'),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Text(
                        c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.name, style: Theme.of(context).textTheme.titleSmall),
                          if (c.phone != null)
                            Text(c.phone!, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 20, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const LoadingWidget(message: 'Müşteriler yükleniyor...'),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/customer/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSearch(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Müşteri Ara'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'İsim veya telefon...'),
          onChanged: (v) => ref.read(_customerSearchQueryProvider.notifier).state = v,
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(_customerSearchQueryProvider.notifier).state = '';
              Navigator.pop(ctx);
            },
            child: const Text('Temizle'),
          ),
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tamam')),
        ],
      ),
    );
  }
}
