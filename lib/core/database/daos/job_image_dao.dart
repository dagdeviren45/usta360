import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'job_image_dao.g.dart';

@DriftAccessor(tables: [JobImages])
class JobImageDao extends DatabaseAccessor<AppDatabase>
    with _$JobImageDaoMixin {
  JobImageDao(super.db);

  /// İşe ait tüm fotoğrafları getir
  Future<List<JobImage>> getImagesByJob(int jobId) {
    return (select(jobImages)
          ..where((i) => i.jobId.equals(jobId))
          ..orderBy([(i) => OrderingTerm.asc(i.sortIndex)]))
        .get();
  }

  /// Fotoğraf ekle
  Future<int> insertImage(JobImagesCompanion image) {
    return into(jobImages).insert(image);
  }

  /// Birden fazla fotoğraf ekle
  Future<void> insertImages(List<JobImagesCompanion> images) async {
    await batch((batch) {
      batch.insertAll(jobImages, images);
    });
  }

  /// Fotoğraf notunu güncelle
  Future<void> updateCaption(int id, String? caption) {
    return (update(jobImages)..where((i) => i.id.equals(id))).write(
      JobImagesCompanion(caption: Value(caption)),
    );
  }

  /// Fotoğrafı sil
  Future<void> deleteImage(int id) {
    return (delete(jobImages)..where((i) => i.id.equals(id))).go();
  }

  /// İşe ait tüm fotoğrafları sil
  Future<void> deleteImagesByJob(int jobId) {
    return (delete(jobImages)..where((i) => i.jobId.equals(jobId))).go();
  }

  /// Fotoğraf sayısını getir
  Future<int> getImageCount(int jobId) async {
    final count = countAll();
    final query = selectOnly(jobImages)
      ..where(jobImages.jobId.equals(jobId))
      ..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Sıralamayı güncelle
  Future<void> updateSortOrders(List<JobImage> images) async {
    await batch((batch) {
      for (int i = 0; i < images.length; i++) {
        batch.update(
          jobImages,
          JobImagesCompanion(sortIndex: Value(i)),
          where: (t) => t.id.equals(images[i].id),
        );
      }
    });
  }

  /// Stream olarak fotoğrafları izle
  Stream<List<JobImage>> watchImagesByJob(int jobId) {
    return (select(jobImages)
          ..where((i) => i.jobId.equals(jobId))
          ..orderBy([(i) => OrderingTerm.asc(i.sortIndex)]))
        .watch();
  }
}
