import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/theme/app_theme.dart';
import '../../core/theme/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../../core/widgets/common_widgets.dart';
import '../../core/database/database.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('⚙️ Ayarlar')),
      body: settingsAsync.when(
        data: (settings) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tema
            GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              child: SwitchListTile(
                title: const Text('Karanlık Mod'),
                subtitle: const Text('Göz dostu karanlık tema'),
                secondary: Icon(
                  themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                  color: AppColors.primary,
                ),
                value: themeMode == ThemeMode.dark,
                onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
                contentPadding: EdgeInsets.zero,
              ),
            ),

            // Firma bilgileri
            GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🏢 Firma Bilgileri', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _settingsItem(context, 'Firma Adı', settings.companyName ?? 'Belirtilmemiş', Icons.business,
                    () => _editCompanyField(context, ref, settings, 'companyName', 'Firma Adı', settings.companyName)),
                  _settingsItem(context, 'Telefon', settings.companyPhone ?? 'Belirtilmemiş', Icons.phone,
                    () => _editCompanyField(context, ref, settings, 'companyPhone', 'Telefon', settings.companyPhone)),
                  _settingsItem(context, 'E-posta', settings.companyEmail ?? 'Belirtilmemiş', Icons.email,
                    () => _editCompanyField(context, ref, settings, 'companyEmail', 'E-posta', settings.companyEmail)),
                  _settingsItem(context, 'Adres', settings.companyAddress ?? 'Belirtilmemiş', Icons.location_on,
                    () => _editCompanyField(context, ref, settings, 'companyAddress', 'Adres', settings.companyAddress)),
                ],
              ),
            ),

            // Varsayılan ayarlar
            GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📊 Varsayılan Ayarlar', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _settingsItem(context, 'Kâr Oranı', '%${settings.defaultProfitMargin.toStringAsFixed(0)}', Icons.trending_up,
                    () => _editProfitMargin(context, ref, settings)),
                ],
              ),
            ),

            // PDF Ayarları
            GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📄 PDF Ayarları', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _settingsItem(context, 'Alt Not', settings.pdfFooterNote ?? 'Belirtilmemiş', Icons.note,
                    () => _editPdfFooterNote(context, ref, settings)),
                ],
              ),
            ),

            // Hakkında
            GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ℹ️ Hakkında', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _settingsItem(context, 'Versiyon', '1.0.0', Icons.info_outline, null),
                  _settingsItem(context, 'Geliştirici', 'MD Tech Software', Icons.code, null),
                ],
              ),
            ),
          ],
        ),
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }

  Widget _settingsItem(BuildContext context, String title, String value, IconData icon, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(icon, size: 20, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(value, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
      trailing: onTap != null ? const Icon(Icons.edit, size: 16) : null,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  void _editCompanyField(BuildContext context, WidgetRef ref, AppSetting settings, String field, String label, String? currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: TextField(controller: controller, autofocus: true, decoration: InputDecoration(labelText: label)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () async {
              final val = controller.text.trim();
              // Mevcut ayarları al ve güncellenmiş versiyonunu kaydet
              switch (field) {
                case 'companyName':
                  await ref.read(settingsDaoProvider).updateSettings(
                    settings.copyWith(companyName: drift.Value(val.isNotEmpty ? val : null)));
                  break;
                case 'companyPhone':
                  await ref.read(settingsDaoProvider).updateSettings(
                    settings.copyWith(companyPhone: drift.Value(val.isNotEmpty ? val : null)));
                  break;
                case 'companyEmail':
                  await ref.read(settingsDaoProvider).updateSettings(
                    settings.copyWith(companyEmail: drift.Value(val.isNotEmpty ? val : null)));
                  break;
                case 'companyAddress':
                  await ref.read(settingsDaoProvider).updateSettings(
                    settings.copyWith(companyAddress: drift.Value(val.isNotEmpty ? val : null)));
                  break;
              }
              ref.invalidate(settingsProvider);
              Navigator.pop(ctx);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _editProfitMargin(BuildContext context, WidgetRef ref, AppSetting settings) {
    final controller = TextEditingController(text: settings.defaultProfitMargin.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Varsayılan Kâr Oranı (%)'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Kâr Oranı (%)', suffixText: '%'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () async {
              final value = double.tryParse(controller.text) ?? settings.defaultProfitMargin;
              await ref.read(settingsDaoProvider).updateDefaultProfitMargin(value);
              ref.invalidate(settingsProvider);
              Navigator.pop(ctx);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _editPdfFooterNote(BuildContext context, WidgetRef ref, AppSetting settings) {
    final controller = TextEditingController(text: settings.pdfFooterNote);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('PDF Alt Not'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Alt Not'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () async {
              await ref.read(settingsDaoProvider).updateSettings(
                settings.copyWith(pdfFooterNote: drift.Value(controller.text.trim().isNotEmpty ? controller.text.trim() : null)),
              );
              ref.invalidate(settingsProvider);
              Navigator.pop(ctx);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}
