import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/database/database.dart';
import '../../core/providers/app_providers.dart';

class CustomerFormScreen extends ConsumerStatefulWidget {
  final int? customerId;
  const CustomerFormScreen({super.key, this.customerId});

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isLoading = false;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.customerId != null) {
      _isEdit = true;
      _loadCustomer();
    }
  }

  Future<void> _loadCustomer() async {
    final c = await ref.read(customerDaoProvider).getCustomerById(widget.customerId!);
    if (c != null) {
      setState(() {
        _nameController.text = c.name;
        _phoneController.text = c.phone ?? '';
        _emailController.text = c.email ?? '';
        _addressController.text = c.address ?? '';
        _notesController.text = c.notes ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Müşteriyi Düzenle' : 'Yeni Müşteri')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Ad Soyad *', prefixIcon: Icon(Icons.person)),
              validator: (v) => v == null || v.isEmpty ? 'Ad Soyad zorunlu' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Telefon', prefixIcon: Icon(Icons.phone)),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-posta', prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Adres', prefixIcon: Icon(Icons.location_on)),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notlar', prefixIcon: Icon(Icons.note)),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveCustomer,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(_isEdit ? 'Güncelle' : 'Müşteri Oluştur'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_isEdit) {
        final existing = await ref.read(customerDaoProvider).getCustomerById(widget.customerId!);
        if (existing != null) {
          await ref.read(customerDaoProvider).updateCustomer(
            existing.copyWith(
              name: _nameController.text.trim(),
              phone: drift.Value(_phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null),
              email: drift.Value(_emailController.text.trim().isNotEmpty ? _emailController.text.trim() : null),
              address: drift.Value(_addressController.text.trim().isNotEmpty ? _addressController.text.trim() : null),
              notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
              updatedAt: DateTime.now(),
            ),
          );
        }
      } else {
        await ref.read(customerDaoProvider).insertCustomer(
          CustomersCompanion.insert(
            name: _nameController.text.trim(),
            phone: drift.Value(_phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null),
            email: drift.Value(_emailController.text.trim().isNotEmpty ? _emailController.text.trim() : null),
            address: drift.Value(_addressController.text.trim().isNotEmpty ? _addressController.text.trim() : null),
            notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
          ),
        );
      }

      ref.invalidate(customersProvider);
      ref.invalidate(customerCountProvider);
      if (widget.customerId != null) ref.invalidate(customerDetailProvider(widget.customerId!));

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
