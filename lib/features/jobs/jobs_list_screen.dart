import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/database/daos/job_dao.dart';

/// İş arama/filtre state
final _searchQueryProvider = StateProvider<String>((ref) => '');
final _statusFilterProvider = StateProvider<String?>((ref) => null);

class JobsListScreen extends ConsumerStatefulWidget {
  const JobsListScreen({super.key});

  @override
  ConsumerState<JobsListScreen> createState() => _JobsListScreenState();
}

class _JobsListScreenState extends ConsumerState<JobsListScreen> {
  final _searchController = TextEditingController();
  bool _isSearchMode = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(_searchQueryProvider);
    final statusFilter = ref.watch(_statusFilterProvider);
    final currencyFormat = NumberFormat.currency(locale: 'tr', symbol: '₺', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: _isSearchMode
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'İş ara...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  ref.read(_searchQueryProvider.notifier).state = value;
                },
              )
            : const Text('🛠️ İşlerim'),
        actions: [
          IconButton(
            icon: Icon(_isSearchMode ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchMode = !_isSearchMode;
                if (!_isSearchMode) {
                  _searchController.clear();
                  ref.read(_searchQueryProvider.notifier).state = '';
                }
              });
            },
          ),
          PopupMenuButton<String?>(
            icon: Badge(
              isLabelVisible: statusFilter != null,
              child: const Icon(Icons.filter_list),
            ),
            onSelected: (value) {
              ref.read(_statusFilterProvider.notifier).state = value;
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: null, child: Text('Tümü')),
              PopupMenuDivider(),
              PopupMenuItem(value: 'draft', child: Text('Taslak')),
              PopupMenuItem(value: 'active', child: Text('Devam Ediyor')),
              PopupMenuItem(value: 'pending', child: Text('Beklemede')),
              PopupMenuItem(value: 'completed', child: Text('Tamamlandı')),
              PopupMenuItem(value: 'cancelled', child: Text('İptal')),
            ],
          ),
        ],
      ),
      body: _buildJobsList(context, ref, searchQuery, statusFilter, currencyFormat),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/job/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildJobsList(
    BuildContext context, WidgetRef ref,
    String searchQuery, String? statusFilter, NumberFormat currencyFormat,
  ) {
    final AsyncValue<List<JobWithCustomer>> jobsAsync;
    if (searchQuery.isNotEmpty) {
      jobsAsync = ref.watch(jobSearchProvider(searchQuery));
    } else if (statusFilter != null) {
      jobsAsync = ref.watch(
        FutureProvider<List<JobWithCustomer>>((ref) {
          return ref.read(jobDaoProvider).getJobsByStatus(statusFilter);
        }),
      );
    } else {
      jobsAsync = ref.watch(jobsProvider);
    }

    return jobsAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return EmptyState(
            icon: Icons.work_off,
            title: searchQuery.isNotEmpty ? 'Sonuç bulunamadı' : 'Henüz iş eklenmemiş',
            subtitle: searchQuery.isNotEmpty ? '"$searchQuery" ile eşleşen iş yok' : 'İlk işinizi eklemek için + butonuna dokunun',
            buttonText: searchQuery.isEmpty ? '+ Yeni İş Ekle' : null,
            onButtonPressed: searchQuery.isEmpty ? () => context.push('/job/new') : null,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final jc = jobs[index];
            return _JobListItem(
              jobWithCustomer: jc,
              currencyFormat: currencyFormat,
              onTap: () => context.push('/job/${jc.job.id}'),
            );
          },
        );
      },
      loading: () => const LoadingWidget(message: 'İşler yükleniyor...'),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }
}

class _JobListItem extends StatelessWidget {
  final JobWithCustomer jobWithCustomer;
  final NumberFormat currencyFormat;
  final VoidCallback? onTap;

  const _JobListItem({required this.jobWithCustomer, required this.currencyFormat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final job = jobWithCustomer.job;
    final customer = jobWithCustomer.customer;

    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 4, height: 56,
            decoration: BoxDecoration(color: _statusColor(job.status), borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(job.title, style: Theme.of(context).textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    StatusBadge(status: job.status),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 13, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(customer.name, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      currencyFormat.format(job.totalSale),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(DateFormat('dd MMM yyyy', 'tr').format(job.createdAt), style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right, size: 20, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'draft': return AppColors.statusDraft;
      case 'active': return AppColors.statusActive;
      case 'pending': return AppColors.statusPending;
      case 'completed': return AppColors.statusCompleted;
      case 'cancelled': return AppColors.statusCancelled;
      default: return AppColors.statusDraft;
    }
  }
}
