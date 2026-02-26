import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../database/database.dart';

/// Yedekleme servisi provider
final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.read(databaseProvider));
});

/// Yedekleme servisi - Veritabanı + fotoğrafları ZIP olarak yedekle
class BackupService {
  final AppDatabase _database;

  BackupService(this._database);

  /// Yedek oluştur → ZIP dosyası
  Future<File?> createBackup() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final archive = Archive();

      // 1. Veritabanı dosyasını ekle
      final dbFile = File(p.join(appDir.path, 'usta360.sqlite'));
      if (await dbFile.exists()) {
        final dbBytes = await dbFile.readAsBytes();
        archive.addFile(ArchiveFile('usta360.sqlite', dbBytes.length, dbBytes));
      }

      // 2. Tüm iş fotoğraflarını ekle
      final jobsDir = Directory(p.join(appDir.path, 'jobs'));
      if (await jobsDir.exists()) {
        await _addDirectoryToArchive(archive, jobsDir, 'jobs');
      }

      // 3. Logo dosyasını ekle (varsa)
      final settings = await _database.settingsDao.getSettings();
      if (settings.logoPath != null && settings.logoPath!.isNotEmpty) {
        final logoFile = File(settings.logoPath!);
        if (await logoFile.exists()) {
          final logoBytes = await logoFile.readAsBytes();
          archive.addFile(ArchiveFile('logo${p.extension(settings.logoPath!)}',
              logoBytes.length, logoBytes));
        }
      }

      // 4. ZIP olarak kaydet
      final encoder = ZipEncoder();
      final zipBytes = encoder.encode(archive);

      if (zipBytes == null) return null;

      final backupDir = Directory(p.join(appDir.path, 'backups'));
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final backupFile =
          File(p.join(backupDir.path, 'usta360_backup_$timestamp.zip'));
      await backupFile.writeAsBytes(zipBytes);

      return backupFile;
    } catch (e) {
      debugPrint('createBackup error: $e');
      return null;
    }
  }

  /// Yedekten geri yükle
  Future<bool> restoreBackup() async {
    try {
      // Kullanıcıdan dosya seç
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) return false;

      final filePath = result.files.first.path;
      if (filePath == null) return false;

      final zipFile = File(filePath);
      final zipBytes = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(zipBytes);

      final appDir = await getApplicationDocumentsDirectory();

      // Veritabanını kapat ve yedekten geri yükle
      for (final file in archive) {
        final fileName = file.name;
        final data = file.content as List<int>;

        if (fileName == 'usta360.sqlite') {
          // DB dosyasını geri yükle
          final dbFile = File(p.join(appDir.path, fileName));
          await dbFile.writeAsBytes(data);
        } else if (fileName.startsWith('jobs/')) {
          // Fotoğrafları geri yükle
          final targetFile = File(p.join(appDir.path, fileName));
          final dir = targetFile.parent;
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          }
          await targetFile.writeAsBytes(data);
        } else if (fileName.startsWith('logo')) {
          final targetFile = File(p.join(appDir.path, fileName));
          await targetFile.writeAsBytes(data);
        }
      }

      return true;
    } catch (e) {
      debugPrint('restoreBackup error: $e');
      return false;
    }
  }

  /// Yedeği paylaş
  Future<void> shareBackup(File backupFile) async {
    await Share.shareXFiles(
      [XFile(backupFile.path)],
      subject: 'Usta360 Yedek',
      text: 'Usta360 Pro uygulama yedeği',
    );
  }

  /// Klasörü archive'e ekle (recursive)
  Future<void> _addDirectoryToArchive(
      Archive archive, Directory dir, String basePath) async {
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        final relativePath = p.relative(entity.path, from: dir.parent.path);
        final bytes = await entity.readAsBytes();
        archive.addFile(ArchiveFile(relativePath, bytes.length, bytes));
      }
    }
  }

  /// Yedek boyutunu hesapla
  Future<String> getBackupSizeEstimate() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      int totalSize = 0;

      // DB boyutu
      final dbFile = File(p.join(appDir.path, 'usta360.sqlite'));
      if (await dbFile.exists()) {
        totalSize += await dbFile.length();
      }

      // Fotoğraf boyutu
      final jobsDir = Directory(p.join(appDir.path, 'jobs'));
      if (await jobsDir.exists()) {
        await for (final entity in jobsDir.list(recursive: true)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }

      // Boyut formatla
      if (totalSize < 1024) return '$totalSize B';
      if (totalSize < 1024 * 1024) {
        return '${(totalSize / 1024).toStringAsFixed(1)} KB';
      }
      if (totalSize < 1024 * 1024 * 1024) {
        return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)} MB';
      }
      return '${(totalSize / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    } catch (e) {
      return 'Hesaplanamadı';
    }
  }
}
