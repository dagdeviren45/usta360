import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'material_template_dao.g.dart';

@DriftAccessor(tables: [MaterialTemplates])
class MaterialTemplateDao extends DatabaseAccessor<AppDatabase>
    with _$MaterialTemplateDaoMixin {
  MaterialTemplateDao(super.db);

  /// Tüm şablonları getir
  Future<List<MaterialTemplate>> getAllTemplates() {
    return (select(materialTemplates)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Kategoriye göre şablonları getir
  Future<List<MaterialTemplate>> getTemplatesByCategory(String category) {
    return (select(materialTemplates)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Şablon ara
  Future<List<MaterialTemplate>> searchTemplates(String query) {
    final q = '%$query%';
    return (select(materialTemplates)
          ..where((t) => t.name.like(q) | t.category.like(q))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Şablon ekle
  Future<int> insertTemplate(MaterialTemplatesCompanion template) {
    return into(materialTemplates).insert(template);
  }

  /// Şablon güncelle
  Future<bool> updateTemplate(MaterialTemplate template) {
    return update(materialTemplates).replace(template);
  }

  /// Şablon sil
  Future<void> deleteTemplate(int id) {
    return (delete(materialTemplates)..where((t) => t.id.equals(id))).go();
  }

  /// Tüm kategorileri getir
  Future<List<String>> getAllCategories() async {
    final results = await select(materialTemplates).get();
    final categories = <String>{};
    for (final template in results) {
      if (template.category != null && template.category!.isNotEmpty) {
        categories.add(template.category!);
      }
    }
    return categories.toList()..sort();
  }
}
