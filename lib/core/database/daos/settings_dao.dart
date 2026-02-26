import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  /// Ayarları getir (Varsayılan yoksa oluştur)
  Future<AppSetting> getSettings() async {
    final results = await select(appSettings).get();
    if (results.isEmpty) {
      await into(appSettings).insert(AppSettingsCompanion.insert());
      return (await select(appSettings).get()).first;
    }
    return results.first;
  }

  /// Ayarların varlığını kontrol et ve gerekirse oluştur (Startup için)
  Future<void> ensureSettingsInitialized() async {
    final results = await select(appSettings).get();
    if (results.isEmpty) {
      await into(appSettings).insert(AppSettingsCompanion.insert());
    }
  }

  /// Ayarları güncelle
  Future<bool> updateSettings(AppSetting settings) {
    return update(appSettings).replace(settings);
  }

  /// Tema modunu güncelle
  Future<void> updateThemeMode(String mode) async {
    final settings = await getSettings();
    await update(appSettings).replace(settings.copyWith(themeMode: mode));
  }

  /// Para birimini güncelle
  Future<void> updateCurrency(String currency) async {
    final settings = await getSettings();
    await update(appSettings).replace(settings.copyWith(currency: currency));
  }

  /// Varsayılan kâr marjını güncelle
  Future<void> updateDefaultProfitMargin(double margin) async {
    final settings = await getSettings();
    await update(appSettings)
        .replace(settings.copyWith(defaultProfitMargin: margin));
  }

  /// Firma bilgilerini güncelle
  Future<void> updateCompanyInfo({
    String? name,
    String? address,
    String? phone,
    String? email,
    String? logoPath,
  }) async {
    final settings = await getSettings();
    await (update(appSettings)..where((s) => s.id.equals(settings.id))).write(
      AppSettingsCompanion(
        companyName: name != null ? Value(name) : const Value.absent(),
        companyAddress: address != null ? Value(address) : const Value.absent(),
        companyPhone: phone != null ? Value(phone) : const Value.absent(),
        companyEmail: email != null ? Value(email) : const Value.absent(),
        logoPath: logoPath != null ? Value(logoPath) : const Value.absent(),
      ),
    );
  }

  /// PDF şablonunu güncelle
  Future<void> updatePdfTemplate(String template) async {
    final settings = await getSettings();
    await update(appSettings)
        .replace(settings.copyWith(pdfTemplate: template));
  }

  /// Premium durumunu güncelle
  Future<void> updatePremiumStatus(bool isPremium) async {
    final settings = await getSettings();
    await update(appSettings)
        .replace(settings.copyWith(isPremium: isPremium));
  }

  /// Stream olarak ayarları izle
  Stream<AppSetting> watchSettings() {
    return select(appSettings).watchSingle();
  }
}
