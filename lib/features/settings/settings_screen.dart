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
                    () => _editField(context, ref, 'companyName', 'Firma Adı', settings.companyName)),
                  _settingsItem(context, 'Telefon', settings.companyPhone ?? 'Belirtilmemiş', Icons.phone,
                    () => _editField(context, ref, 'companyPhone', 'Telefon', settings.companyPhone)),
                  _settingsItem(context, 'E-posta', settings.companyEmail ?? 'Belirtilmemiş', Icons.email,
                    () => _editField(context, ref, 'companyEmail', 'E-posta', settings.companyEmail)),
                  _settingsItem(context, 'Adres', settings.companyAddress ?? 'Belirtilmemiş', Icons.location_on,
                    () => _editField(context, ref, 'companyAddress', 'Adres', settings.companyAddress)),
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
                  _settingsItem(context, 'Kâr Oranı', '%${settings.defaultProfitRate.toStringAsFixed(0)}', Icons.trending_up,
                    () => _editNumberField(context, ref, 'defaultProfitRate', 'Varsayılan Kâr Oranı (%)', settings.defaultProfitRate)),
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
                    () => _editField(context, ref, 'pdfFooterNote', 'PDF Alt Not', settings.pdfFooterNote)),
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

  void _editField(BuildContext context, WidgetRef ref, String field, String label, String? currentValue) {
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
              await ref.read(settingsDaoProvider).updateField(field, controller.text.trim());
              ref.invalidate(settingsProvider);
              Navigator.pop(ctx);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _editNumberField(BuildContext context, WidgetRef ref, String field, String label, double currentValue) {
    final controller = TextEditingController(text: currentValue.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () async {
              final value = double.tryParse(controller.text) ?? currentValue;
              await ref.read(settingsDaoProvider).updateField(field, value.toString());
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
