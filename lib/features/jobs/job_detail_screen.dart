import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/services/pdf_service.dart';
import '../../core/services/photo_service.dart';
import '../../core/database/database.dart';
import '../../core/theme/app_colors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/services/ad_helper.dart';

class JobDetailScreen extends ConsumerStatefulWidget {
  final int jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final currencyFormat = NumberFormat.currency(locale: 'tr', symbol: '₺', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobAsync = ref.watch(jobDetailProvider(widget.jobId));

    return jobAsync.when(
      data: (jobWithCustomer) {
        if (jobWithCustomer == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('İş Bulunamadı')),
            body: const EmptyState(icon: Icons.error_outline, title: 'İş bulunamadı'),
          );
        }

        final job = jobWithCustomer.job;
        final customer = jobWithCustomer.customer;

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(job.title,
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
                                    maxLines: 2, overflow: TextOverflow.ellipsis),
                                ),
                                StatusBadge(status: job.status),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.person_outline, size: 14, color: Colors.white70),
                                const SizedBox(width: 4),
                                Text(customer.name, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                                const Spacer(),
                                Text(DateFormat('dd MMM yyyy', 'tr').format(job.createdAt),
                                  style: const TextStyle(fontSize: 12, color: Colors.white60)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () => context.push('/job/${widget.jobId}/edit'),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (action) => _handleAction(action, jobWithCustomer),
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 'pdf',
                        child: Row(children: [
                          Icon(Icons.picture_as_pdf, color: Colors.blue, size: 20),
                          SizedBox(width: 8),
                          Text('PDF Teklif Oluştur', style: TextStyle(color: Colors.blue)),
                        ]),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(children: [
                          Icon(Icons.delete_outline, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('Sil', style: TextStyle(color: Colors.red)),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: const [
                      Tab(text: '📋 Özet'),
                      Tab(text: '🛠️ Kalemler'),
                      Tab(text: '💰 Ödemeler'),
                      Tab(text: '📸 Fotoğraflar'),
                      Tab(text: '⏰ Hatırlatıcılar'),
                    ],
                  ),
                  Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _SummaryTab(job: job, customer: customer, cf: currencyFormat),
                _LineItemsTab(jobId: widget.jobId, cf: currencyFormat),
                _PaymentsTab(jobId: widget.jobId, job: job, cf: currencyFormat),
                _PhotosTab(jobId: widget.jobId),
                _RemindersTab(jobId: widget.jobId),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: LoadingWidget(message: 'İş detayı yükleniyor...')),
      error: (e, _) => Scaffold(appBar: AppBar(), body: Center(child: Text('Hata: $e'))),
    );
  }

  void _handleAction(String action, dynamic jobWithCustomer) async {
    final job = jobWithCustomer.job;
    
    if (action == 'pdf') {
      _showRewardedAdAndGeneratePdf(jobWithCustomer);
      return;
    }

    if (action == 'delete') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('İşi Sil'),
          content: const Text('Bu iş silinecek. Devam etmek istiyor musunuz?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Sil'),
            ),
          ],
        ),
      );

      if (confirm == true && mounted) {
        await ref.read(jobDaoProvider).softDeleteJob(job.id);
        ref.invalidate(jobsProvider);
        ref.invalidate(recentJobsProvider);
        ref.invalidate(jobCountProvider);
        if (mounted) context.pop();
      }
    }
  }

  void _showRewardedAdAndGeneratePdf(dynamic jobWithCustomer) {
    bool _adHandled = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    // Timeout: 5 saniye içinde reklam yüklenmezse direkt PDF oluştur
    Future.delayed(const Duration(seconds: 5), () {
      if (!_adHandled && mounted) {
        _adHandled = true;
        Navigator.pop(context);
        _generatePdf(jobWithCustomer);
      }
    });

    RewardedInterstitialAd.load(
      adUnitId: AdHelper.pdfRewardedAdUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (_adHandled) { ad.dispose(); return; }
          _adHandled = true;
          Navigator.pop(context); // Close loading dialog
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _generatePdf(jobWithCustomer);
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _generatePdf(jobWithCustomer);
            },
          );
          ad.show(onUserEarnedReward: (ad, reward) {
            // Reward earned
          });
        },
        onAdFailedToLoad: (error) {
          if (_adHandled) return;
          _adHandled = true;
          debugPrint('RewardedInterstitialAd failed to load: $error');
          Navigator.pop(context); // Close loading dialog
          _generatePdf(jobWithCustomer); // Proceed even if ad fails
        },
      ),
    );
  }

  Future<void> _generatePdf(dynamic jobWithCustomer) async {
    try {
      final job = jobWithCustomer.job;
      final customer = jobWithCustomer.customer;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('PDF Oluşturuluyor...'),
            ],
          ),
        ),
      );

      final lineItems = await ref.read(lineItemDaoProvider).getItemsByJob(job.id);
      final settings = await ref.read(settingsDaoProvider).getSettings();
      
      final pdfService = ref.read(pdfServiceProvider);
      final pdfBytes = await pdfService.generateProposalPdf(
        job: job,
        customer: customer,
        lineItems: lineItems,
        settings: settings,
      );

      if (mounted) {
        Navigator.pop(context); // Close loading
        await pdfService.previewPdf(context, pdfBytes, job.title);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color bgColor;
  _TabBarDelegate(this.tabBar, this.bgColor);

  @override
  Widget build(context, shrinkOffset, overlapsContent) => Container(color: bgColor, child: tabBar);
  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

// ─── ÖZET TAB ────────────────────────────────────────────────
class _SummaryTab extends ConsumerWidget {
  final Job job;
  final Customer customer;
  final NumberFormat cf;
  const _SummaryTab({required this.job, required this.customer, required this.cf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Müşteri bilgisi
        GlassCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Text('Müşteri Bilgileri', style: Theme.of(context).textTheme.titleSmall),
              ]),
              const Divider(height: 16),
              _infoRow('Ad', customer.name),
              if (customer.phone != null) _infoRow('Telefon', customer.phone!),
              if (customer.email != null) _infoRow('E-posta', customer.email!),
              if (customer.address != null) _infoRow('Adres', customer.address!),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // İş bilgileri
        GlassCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.info_outline, size: 20),
                const SizedBox(width: 8),
                Text('ℹ️ İş Bilgileri', style: Theme.of(context).textTheme.titleSmall),
              ]),
              const Divider(height: 16),
              if (job.description != null && job.description!.isNotEmpty) _infoRow('Açıklama', job.description!),
              if (job.location != null) _infoRow('Konum', job.location!),
              if (job.dueDate != null) _infoRow('Teslim Tarihi', DateFormat('dd.MM.yyyy').format(job.dueDate!)),
              _infoRow('Oluşturulma', DateFormat('dd.MM.yyyy HH:mm').format(job.createdAt)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Usta Görünümü (gizli)
        GlassCard(
          margin: EdgeInsets.zero,
          borderColor: AppColors.primary.withOpacity(0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.visibility, size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('👨‍🔧 Usta Görünümü', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.primary)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: const Text('GİZLİ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ),
              ]),
              const Divider(height: 16),
              _financialRow('Toplam Maliyet', cf.format(job.totalCost), Colors.orange),
              _financialRow('Toplam Satış', cf.format(job.totalSale), AppColors.primary),
              _financialRow('Kâr', cf.format(job.profit), AppColors.success),
              _financialRow('Kâr Oranı', '%${job.profitRate.toStringAsFixed(1)}', AppColors.success),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ek Masraflar (Gider)', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text(cf.format(job.customExpense), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => _showEditExpenseSheet(context, ref, job),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Düzenle'),
                    style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Ödeme Durumu
        GlassCard(
          margin: EdgeInsets.zero,
          borderColor: AppColors.accent.withOpacity(0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.account_balance_wallet, size: 20, color: AppColors.accent),
                const SizedBox(width: 8),
                Text('💳 Ödeme Durumu', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.accent)),
              ]),
              const Divider(height: 16),
              Builder(builder: (context) {
                final jobTotal = job.quotedPrice > 0 ? job.quotedPrice : job.totalSale;
                final remaining = (jobTotal - job.collectedAmount).clamp(0, double.infinity);
                return Column(children: [
                  if (job.quotedPrice > 0) _financialRow('Teklif Fiyatı', cf.format(job.quotedPrice), AppColors.primary),
                  _financialRow('Toplam Tutar', cf.format(jobTotal), AppColors.primary),
                  _financialRow('Kapora', cf.format(job.depositAmount), Colors.orange),
                  _financialRow('Tahsil Edilen', cf.format(job.collectedAmount), AppColors.success),
                  _financialRow('Kalan Alacak', cf.format(remaining), remaining > 0 ? Colors.red : AppColors.success),
                ]);
              }),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditExpenseSheet(BuildContext context, WidgetRef ref, Job job) {
    final controller = TextEditingController(text: job.customExpense.toString());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('💸 Ek Masraflar', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Masraf Tutarı (₺)', suffixText: '₺'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final expense = double.tryParse(controller.text) ?? 0;
                  await ref.read(jobDaoProvider).updateJob(job.copyWith(customExpense: expense));
                  await ref.read(jobDaoProvider).updateJobTotals(job.id);
                  ref.invalidate(jobDetailProvider(job.id));
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('Güncelle'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _financialRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

// ─── KALEMLER TAB ────────────────────────────────────────────
class _LineItemsTab extends ConsumerWidget {
  final int jobId;
  final NumberFormat cf;
  const _LineItemsTab({required this.jobId, required this.cf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(jobLineItemsProvider(jobId));

    return Scaffold(
      body: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.list_alt,
              title: 'Kalem eklenmemiş',
              subtitle: 'Malzeme, işçilik veya diğer giderleri ekleyin',
              buttonText: 'Kalem Ekle',
              onButtonPressed: () => context.push('/job/$jobId/line-item/new'),
            );
          }

          final materials = items.where((i) => i.type == 'material').toList();
          final labors = items.where((i) => i.type == 'labor').toList();
          final others = items.where((i) => i.type == 'other').toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (materials.isNotEmpty) ...[
                _sectionTitle(context, '🔧 Malzeme', materials.length),
                ...materials.map((item) => _ItemCard(item: item, cf: cf, jobId: jobId)),
                const SizedBox(height: 8),
              ],
              if (labors.isNotEmpty) ...[
                _sectionTitle(context, '👷 İşçilik', labors.length),
                ...labors.map((item) => _ItemCard(item: item, cf: cf, jobId: jobId)),
                const SizedBox(height: 8),
              ],
              if (others.isNotEmpty) ...[
                _sectionTitle(context, '📦 Diğer', others.length),
                ...others.map((item) => _ItemCard(item: item, cf: cf, jobId: jobId)),
              ],
            ],
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => context.push('/job/$jobId/line-item/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('$count', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final LineItem item;
  final NumberFormat cf;
  final int jobId;
  const _ItemCard({required this.item, required this.cf, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final total = item.salePerUnit * item.quantity;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      onTap: () => context.push('/job/$jobId/line-item/${item.id}/edit'),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity.toStringAsFixed(item.quantity == item.quantity.roundToDouble() ? 0 : 2)} ${item.unit} × ${cf.format(item.salePerUnit)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(cf.format(total), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}

// ─── FOTOĞRAFLAR TAB ─────────────────────────────────────────
class _PhotosTab extends ConsumerWidget {
  final int jobId;
  const _PhotosTab({required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(jobImagesProvider(jobId));

    return imagesAsync.when(
      data: (images) {
        if (images.isEmpty) {
          return EmptyState(
            icon: Icons.photo_library_outlined,
            title: 'Fotoğraf eklenmemiş',
            subtitle: 'Kamera veya galeriden fotoğraf ekleyin',
            buttonText: 'Fotoğraf Ekle',
            onButtonPressed: () => context.push('/job/$jobId/photos'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8,
          ),
          itemCount: images.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () => context.push('/job/$jobId/photos'),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 28, color: AppColors.primary),
                      SizedBox(height: 4),
                      Text('Ekle', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ),
              );
            }

            final image = images[index - 1];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            );
          },
        );
      },
      loading: () => const LoadingWidget(),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }
}

// ─── HATIRLATICILAR TAB ──────────────────────────────────────
class _RemindersTab extends ConsumerWidget {
  final int jobId;
  const _RemindersTab({required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(jobRemindersProvider(jobId));

    return Scaffold(
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return EmptyState(
              icon: Icons.notifications_off_outlined,
              title: 'Hatırlatıcı yok',
              subtitle: 'Bu iş için hatırlatıcı ekleyin',
              buttonText: 'Hatırlatıcı Ekle',
              onButtonPressed: () => context.push('/job/$jobId/reminder/new'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final r = reminders[index];
              return GlassCard(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 4, height: 40,
                      decoration: BoxDecoration(
                        color: r.isCompleted ? AppColors.success : AppColors.warning,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title, style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: r.isCompleted ? TextDecoration.lineThrough : null,
                          )),
                          Text(DateFormat('dd.MM.yyyy HH:mm').format(r.scheduledAt),
                            style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    if (!r.isCompleted)
                      IconButton(
                        icon: const Icon(Icons.check_circle_outline, color: AppColors.success),
                        onPressed: () async {
                          await ref.read(reminderDaoProvider).markAsCompleted(r.id, true);
                          ref.invalidate(jobRemindersProvider(jobId));
                        },
                      ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => context.push('/job/$jobId/reminder/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─── ÖDEMELER TAB ────────────────────────────────────────────
class _PaymentsTab extends ConsumerWidget {
  final int jobId;
  final Job job;
  final NumberFormat cf;
  const _PaymentsTab({required this.jobId, required this.job, required this.cf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(jobPaymentsProvider(jobId));

    return Scaffold(
      body: paymentsAsync.when(
        data: (payments) {
          if (payments.isEmpty) {
            return EmptyState(
              icon: Icons.payment,
              title: 'Ödeme kaydı yok',
              subtitle: 'Bu iş için ödeme ekleyin',
              buttonText: 'Ödeme Ekle',
              onButtonPressed: () => _showAddPaymentSheet(context, ref),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final p = payments[index];
              return GlassCard(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _typeColor(p.type).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(_typeIcon(p.type), color: _typeColor(p.type), size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_typeLabel(p.type), style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(DateFormat('dd.MM.yyyy').format(p.paymentDate), style: Theme.of(context).textTheme.bodySmall),
                          if (p.notes != null && p.notes!.isNotEmpty) Text(p.notes!, style: Theme.of(context).textTheme.bodySmall, maxLines: 1),
                        ],
                      ),
                    ),
                    Text(cf.format(p.amount), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _typeColor(p.type))),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _showAddPaymentSheet(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPaymentSheet(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    String selectedType = 'payment';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('💰 Ödeme Ekle', style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 16),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'payment', label: Text('Ödeme'), icon: Icon(Icons.payment)),
                  ButtonSegment(value: 'deposit', label: Text('Kapora'), icon: Icon(Icons.savings)),
                ],
                selected: {selectedType},
                onSelectionChanged: (v) => setModalState(() => selectedType = v.first),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Tutar (₺)', suffixText: '₺'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Not (isteğe bağlı)'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final amount = double.tryParse(amountController.text) ?? 0;
                    if (amount > 0) {
                      await ref.read(paymentDaoProvider).insertPayment(
                        PaymentsCompanion.insert(
                          jobId: jobId,
                          amount: amount,
                          type: drift.Value(selectedType),
                          notes: drift.Value(notesController.text.isNotEmpty ? notesController.text : null),
                        ),
                      );

                      // Toplam tahsilatı güncelle
                      final allPayments = await ref.read(paymentDaoProvider).getPaymentsByJob(jobId);
                      double totalCollected = 0;
                      double totalDeposit = 0;
                      for (final p in allPayments) {
                        if (p.type == 'deposit') {
                          totalDeposit += p.amount;
                        } else {
                          totalCollected += p.amount;
                        }
                      }
                      await ref.read(jobDaoProvider).updateJob(
                        job.copyWith(
                          collectedAmount: totalCollected + totalDeposit,
                          depositAmount: totalDeposit,
                        ),
                      );
                      ref.invalidate(jobPaymentsProvider(jobId));
                      ref.invalidate(jobDetailProvider(jobId));
                      if (ctx.mounted) Navigator.pop(ctx);
                    }
                  },
                  child: const Text('Kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'deposit': return Colors.orange;
      case 'refund': return Colors.red;
      default: return AppColors.success;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'deposit': return Icons.savings;
      case 'refund': return Icons.undo;
      default: return Icons.payment;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'deposit': return 'Kapora';
      case 'refund': return 'İade';
      default: return 'Ödeme';
    }
  }
}
