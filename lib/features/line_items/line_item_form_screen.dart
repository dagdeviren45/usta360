import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/database/database.dart';
import '../../core/providers/app_providers.dart';

class LineItemFormScreen extends ConsumerStatefulWidget {
  final int jobId;
  final int? lineItemId;
  const LineItemFormScreen({super.key, required this.jobId, this.lineItemId});

  @override
  ConsumerState<LineItemFormScreen> createState() => _LineItemFormScreenState();
}

class _LineItemFormScreenState extends ConsumerState<LineItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _costController = TextEditingController(text: '0');
  final _saleController = TextEditingController(text: '0');
  final _notesController = TextEditingController();

  String _type = 'material';
  String _unit = 'adet';
  bool _isLoading = false;
  bool _isEdit = false;

  final _units = ['adet', 'm²', 'm', 'kg', 'lt', 'paket', 'kutu', 'top', 'saat', 'gün', 'diğer'];

  @override
  void initState() {
    super.initState();
    if (widget.lineItemId != null) {
      _isEdit = true;
      _loadItem();
    }
  }

  Future<void> _loadItem() async {
    final item = await ref.read(lineItemDaoProvider).getItemById(widget.lineItemId!);
    if (item != null) {
      setState(() {
        _nameController.text = item.name;
        _quantityController.text = item.quantity.toString();
        _costController.text = item.costPerUnit.toString();
        _saleController.text = item.salePerUnit.toString();
        _notesController.text = item.notes ?? '';
        _type = item.type;
        _unit = item.unit;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _costController.dispose();
    _saleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cost = double.tryParse(_costController.text) ?? 0;
    final sale = double.tryParse(_saleController.text) ?? 0;
    final qty = double.tryParse(_quantityController.text) ?? 0;
    final totalCost = cost * qty;
    final totalSale = sale * qty;
    final profit = totalSale - totalCost;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Kalemi Düzenle' : 'Yeni Kalem'),
        actions: [
          if (_isEdit)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteItem,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tür seçimi
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'material', label: Text('Malzeme'), icon: Icon(Icons.build)),
                ButtonSegment(value: 'labor', label: Text('İşçilik'), icon: Icon(Icons.engineering)),
                ButtonSegment(value: 'other', label: Text('Diğer'), icon: Icon(Icons.category)),
              ],
              selected: {_type},
              onSelectionChanged: (v) => setState(() => _type = v.first),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Kalem Adı *', prefixIcon: Icon(Icons.label)),
              validator: (v) => v == null || v.isEmpty ? 'Ad zorunlu' : null,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Miktar'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: _unit,
                    decoration: const InputDecoration(labelText: 'Birim'),
                    items: _units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                    onChanged: (v) => setState(() => _unit = v ?? 'adet'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _costController,
                    decoration: const InputDecoration(labelText: 'Maliyet (₺)', suffixText: '₺'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _saleController,
                    decoration: const InputDecoration(labelText: 'Satış (₺)', suffixText: '₺'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hesaplama önizleme
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  _calcRow('Toplam Maliyet', '₺${totalCost.toStringAsFixed(2)}', Colors.orange),
                  _calcRow('Toplam Satış', '₺${totalSale.toStringAsFixed(2)}', Theme.of(context).colorScheme.primary),
                  const Divider(),
                  _calcRow('Kâr', '₺${profit.toStringAsFixed(2)}', profit >= 0 ? Colors.green : Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notlar', prefixIcon: Icon(Icons.note)),
              maxLines: 2,
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveItem,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(_isEdit ? 'Güncelle' : 'Kalem Ekle'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calcRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final quantity = double.tryParse(_quantityController.text) ?? 1;
      final costPerUnit = double.tryParse(_costController.text) ?? 0;
      final salePerUnit = double.tryParse(_saleController.text) ?? 0;

      if (_isEdit) {
        final existing = await ref.read(lineItemDaoProvider).getItemById(widget.lineItemId!);
        if (existing != null) {
          await ref.read(lineItemDaoProvider).updateItem(
            existing.copyWith(
              name: _nameController.text.trim(),
              type: _type,
              unit: _unit,
              quantity: quantity,
              costPerUnit: costPerUnit,
              salePerUnit: salePerUnit,
              notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
            ),
          );
        }
      } else {
        await ref.read(lineItemDaoProvider).insertItem(
          LineItemsCompanion.insert(
            jobId: widget.jobId,
            name: _nameController.text.trim(),
            type: drift.Value(_type),
            unit: drift.Value(_unit),
            quantity: drift.Value(quantity),
            costPerUnit: drift.Value(costPerUnit),
            salePerUnit: drift.Value(salePerUnit),
            notes: drift.Value(_notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null),
          ),
        );
      }

      // İş toplamlarını güncelle
      await ref.read(jobDaoProvider).updateJobTotals(widget.jobId);
      ref.invalidate(jobLineItemsProvider(widget.jobId));
      ref.invalidate(jobDetailProvider(widget.jobId));

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteItem() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kalemi Sil'),
        content: const Text('Bu kalem silinecek. Devam?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('Sil')),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(lineItemDaoProvider).deleteItem(widget.lineItemId!);
      await ref.read(jobDaoProvider).updateJobTotals(widget.jobId);
      ref.invalidate(jobLineItemsProvider(widget.jobId));
      ref.invalidate(jobDetailProvider(widget.jobId));
      if (mounted) context.pop();
    }
  }
}
