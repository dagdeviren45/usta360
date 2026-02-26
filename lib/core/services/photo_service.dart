import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Fotoğraf servisi provider
final photoServiceProvider = Provider<PhotoService>((ref) => PhotoService());

/// Fotoğraf servisi - flutter_image_compress KALDIRILDI, sadece image_picker kullanılıyor
class PhotoService {
  final ImagePicker _picker = ImagePicker();

  /// Kameradan fotoğraf çek
  Future<File?> takePhoto({int quality = 85}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: quality,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      debugPrint('takePhoto error: $e');
      return null;
    }
  }

  /// Galeriden fotoğraf seç
  Future<File?> pickPhoto({int quality = 85}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: quality,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      debugPrint('pickPhoto error: $e');
      return null;
    }
  }

  /// Galeriden çoklu fotoğraf seç
  Future<List<File>> pickMultiplePhotos({int quality = 85}) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: quality,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return images.map((x) => File(x.path)).toList();
    } catch (e) {
      debugPrint('pickMultiplePhotos error: $e');
      return [];
    }
  }

  /// Fotoğrafı iş klasörüne kaydet (sıkıştırma YOK - image_picker zaten quality ve maxWidth ile sıkıştırır)
  Future<String> savePhotoForJob(File photo, int jobId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final jobDir = Directory(p.join(appDir.path, 'jobs', jobId.toString(), 'images'));

    if (!await jobDir.exists()) {
      await jobDir.create(recursive: true);
    }

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${p.basename(photo.path)}';
    final targetPath = p.join(jobDir.path, fileName);

    final savedFile = await photo.copy(targetPath);
    return savedFile.path;
  }

  /// Fotoğrafı sil
  Future<void> deletePhoto(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('deletePhoto error: $e');
    }
  }

  /// İşe ait tüm fotoğrafları sil
  Future<void> deleteAllPhotosForJob(int jobId) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final jobDir = Directory(p.join(appDir.path, 'jobs', jobId.toString(), 'images'));
      if (await jobDir.exists()) {
        await jobDir.delete(recursive: true);
      }
    } catch (e) {
      debugPrint('deleteAllPhotosForJob error: $e');
    }
  }
}
