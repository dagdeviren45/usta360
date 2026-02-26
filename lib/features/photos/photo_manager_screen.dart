import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/app_providers.dart';
import '../../core/services/photo_service.dart';
import '../../core/database/database.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/common_widgets.dart';

class PhotoManagerScreen extends ConsumerWidget {
  final int jobId;
  const PhotoManagerScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(jobImagesProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('📸 Fotoğraflar'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (action) => _handleAction(context, ref, action),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'camera', child: Text('📷 Kamera')),
              PopupMenuItem(value: 'gallery', child: Text('🖼️ Galeriden Seç')),
            ],
          ),
        ],
      ),
      body: imagesAsync.when(
        data: (images) {
          if (images.isEmpty) {
            return EmptyState(
              icon: Icons.photo_library_outlined,
              title: 'Fotoğraf yok',
              subtitle: 'Kamera veya galeriden fotoğraf ekleyin',
              buttonText: 'Fotoğraf Ekle',
              onButtonPressed: () => _handleAction(context, ref, 'gallery'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final image = images[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(image.path),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _deletePhoto(context, ref, image),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleAction(context, ref, 'camera'),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future<void> _handleAction(BuildContext context, WidgetRef ref, String action) async {
    File? photo;

    if (action == 'camera') {
      photo = await ref.read(photoServiceProvider).takePhoto();
    } else if (action == 'gallery') {
      photo = await ref.read(photoServiceProvider).pickPhoto();
    }

    if (photo != null) {
      final savedPath = await ref.read(photoServiceProvider).savePhotoForJob(photo, jobId);
      await ref.read(jobImageDaoProvider).insertImage(
        JobImagesCompanion.insert(jobId: jobId, path: savedPath),
      );
      ref.invalidate(jobImagesProvider(jobId));
    }
  }

  Future<void> _deletePhoto(BuildContext context, WidgetRef ref, JobImage image) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Fotoğrafı Sil'),
        content: const Text('Bu fotoğraf silinecek. Devam?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('Sil')),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(photoServiceProvider).deletePhoto(image.path);
      await ref.read(jobImageDaoProvider).deleteImage(image.id);
      ref.invalidate(jobImagesProvider(jobId));
    }
  }
}
