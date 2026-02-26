import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/database/database.dart';
import '../../core/providers/app_providers.dart';
import '../../core/services/notification_service.dart';

class ReminderFormScreen extends ConsumerStatefulWidget {
  final int? jobId;
  const ReminderFormScreen({super.key, this.jobId});

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⏰ Hatırlatıcı Ekle')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Başlık *', prefixIcon: Icon(Icons.title)),
              validator: (v) => v == null || v.isEmpty ? 'Başlık zorunlu' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama', prefixIcon: Icon(Icons.description)),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(DateFormat('dd.MM.yyyy').format(_selectedDate)),
              subtitle: const Text('Tarih'),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(_selectedTime.format(context)),
              subtitle: const Text('Saat'),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (time != null) setState(() => _selectedTime = time);
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveReminder,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Hatırlatıcı Oluştur'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final scheduledAt = DateTime(
        _selectedDate.year, _selectedDate.month, _selectedDate.day,
        _selectedTime.hour, _selectedTime.minute,
      );

      final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;

      await ref.read(reminderDaoProvider).insertReminder(
        RemindersCompanion.insert(
          title: _titleController.text.trim(),
          scheduledAt: scheduledAt,
          jobId: drift.Value(widget.jobId),
          description: drift.Value(_descriptionController.text.trim().isNotEmpty ? _descriptionController.text.trim() : null),
          notificationId: drift.Value(notificationId),
        ),
      );

      // Bildirim planla
      await ref.read(notificationServiceProvider).scheduleReminder(
        notificationId: notificationId,
        title: _titleController.text.trim(),
        body: _descriptionController.text.trim().isNotEmpty ? _descriptionController.text.trim() : 'Hatırlatıcı zamanı geldi!',
        scheduledAt: scheduledAt,
      );

      ref.invalidate(todayRemindersProvider);
      ref.invalidate(upcomingRemindersProvider);
      if (widget.jobId != null) ref.invalidate(jobRemindersProvider(widget.jobId!));

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
