import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';

import '../../core/database/database.dart';
import '../../core/providers/app_providers.dart';

class JobFormScreen extends ConsumerStatefulWidget {
  final int? jobId;
  final int? customerId;
  const JobFormScreen({super.key, this.jobId, this.customerId});

  @override
  ConsumerState<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends ConsumerState<JobFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _quotedPriceController = TextEditingController();

  int? _selectedCustomerId;
  String _status = 'draft';
  DateTime? _dueDate;
  bool _isLoading = false;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _selectedCustomerId = widget.customerId;
    if (widget.jobId != null) {
      _isEdit = true;
      _loadJob();
    }
  }

  Future<void> _loadJob() async {
    final jc = await ref.read(jobDaoProvider).getJobById(widget.jobId!);
    if (jc != null) {
      setState(() {
        _titleController.text = jc.job.title;
        _descriptionController.text = jc.job.description ?? '';
        _locationController.text = jc.job.location ?? '';
        _quotedPriceController.text = jc.job.quotedPrice > 0 ? jc.job.quotedPrice.toString() : '';
        _selectedCustomerId = jc.job.customerId;
        _status = jc.job.status;
        _dueDate = jc.job.dueDate;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _quotedPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'İşi Düzenle' : 'Yeni İş'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Müşteri seçimi
            customersAsync.when(
              data: (customers) {
                return DropdownButtonFormField<int>(
                  value: _selectedCustomerId,
                  decoration: const InputDecoration(
                    labelText: 'Müşteri *',
                    prefixIcon: Icon(Icons.person),
                  ),
                  items: [
                    ...customers.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))),
                  ],
                  onChanged: (v) => setState(() => _selectedCustomerId = v),
                  validator: (v) => v == null ? 'Müşteri seçiniz' : null,
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Müşteriler yüklenemedi'),
            ),
            const SizedBox(height: 8),
            // Yeni müşteri ekle butonu
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () async {
                  await context.push('/customer/new');
                  ref.invalidate(customersProvider);
                },
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Yeni Müşteri'),
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'İş Başlığı *',
                prefixIcon: Icon(Icons.work),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Başlık gerekli' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Açıklama',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Konum/Adres',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _quotedPriceController,
              decoration: const InputDecoration(
                labelText: 'Teklif Fiyatı (₺)',
                prefixIcon: Icon(Icons.monetization_on),
                suffixText: '₺',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),

            // Durum
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(
                labelText: 'Durum',
                prefixIcon: Icon(Icons.flag),
              ),
              items: const [
                DropdownMenuItem(value: 'draft', child: Text('Taslak')),
                DropdownMenuItem(value: 'active', child: Text('Devam Ediyor')),
                DropdownMenuItem(value: 'pending', child: Text('Beklemede')),
                DropdownMenuItem(value: 'completed', child: Text('Tamamlandı')),
                DropdownMenuItem(value: 'cancelled', child: Text('İptal')),
              ],
              onChanged: (v) => setState(() => _status = v ?? 'draft'),
            ),
            const SizedBox(height: 16),

            // Teslim tarihi
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(_dueDate != null
                  ? DateFormat('dd.MM.yyyy').format(_dueDate!)
                  : 'Teslim Tarihi (opsiyonel)'),
              trailing: _dueDate != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _dueDate = null),
                    )
                  : null,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) setState(() => _dueDate = date);
              },
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveJob,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(_isEdit ? 'Güncelle' : 'İş Oluştur'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveJob() async {
    if (!_formKey.currentState!.validate() || _selectedCustomerId == null) return;

    setState(() => _isLoading = true);

    try {
      final quotedPrice = double.tryParse(_quotedPriceController.text) ?? 0;

      if (_isEdit) {
        final existing = await ref.read(jobDaoProvider).getJobById(widget.jobId!);
        if (existing != null) {
          await ref.read(jobDaoProvider).updateJob(
            existing.job.copyWith(
              title: _titleController.text.trim(),
              description: drift.Value(_descriptionController.text.trim()),
              location: drift.Value(_locationController.text.trim().isNotEmpty ? _locationController.text.trim() : null),
              customerId: _selectedCustomerId!,
              status: _status,
              quotedPrice: quotedPrice,
              dueDate: drift.Value(_dueDate),
            ),
          );
        }
      } else {
        await ref.read(jobDaoProvider).insertJob(
          JobsCompanion.insert(
            title: _titleController.text.trim(),
            customerId: _selectedCustomerId!,
            description: drift.Value(_descriptionController.text.trim()),
            location: drift.Value(_locationController.text.trim().isNotEmpty ? _locationController.text.trim() : null),
            status: drift.Value(_status),
            quotedPrice: drift.Value(quotedPrice),
            dueDate: drift.Value(_dueDate),
          ),
        );
      }

      ref.invalidate(jobsProvider);
      ref.invalidate(recentJobsProvider);
      ref.invalidate(jobCountProvider);
      if (widget.jobId != null) ref.invalidate(jobDetailProvider(widget.jobId!));

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
