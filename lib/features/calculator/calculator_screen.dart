import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/common_widgets.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Kâr hesaplayıcı
  final _costController = TextEditingController();
  final _profitRateController = TextEditingController(text: '30');
  double _salePrice = 0;
  double _profit = 0;

  // Malzeme hesaplayıcı
  final _m2Controller = TextEditingController();
  final _pricePerM2Controller = TextEditingController();
  double _totalMaterial = 0;

  final _currencyFormat = NumberFormat.currency(locale: 'tr', symbol: '₺', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _costController.dispose();
    _profitRateController.dispose();
    _m2Controller.dispose();
    _pricePerM2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧮 Hesap Makinesi'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '💰 Kâr Hesapla'),
            Tab(text: '📐 Malzeme'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfitCalculator(context),
          _buildMaterialCalculator(context),
        ],
      ),
    );
  }

  Widget _buildProfitCalculator(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kâr Hesaplayıcısı', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Maliyet (₺)', suffixText: '₺', prefixIcon: Icon(Icons.money_off)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculateProfit(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _profitRateController,
                decoration: const InputDecoration(labelText: 'Kâr Oranı (%)', suffixText: '%', prefixIcon: Icon(Icons.percent)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculateProfit(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Satış Fiyatı:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(_currencyFormat.format(_salePrice), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Kâr:', style: TextStyle(fontSize: 14)),
                        Text(_currencyFormat.format(_profit), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.success)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialCalculator(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GlassCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Malzeme Hesaplayıcısı', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _m2Controller,
                decoration: const InputDecoration(labelText: 'Alan (m²)', suffixText: 'm²', prefixIcon: Icon(Icons.square_foot)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculateMaterial(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pricePerM2Controller,
                decoration: const InputDecoration(labelText: 'Birim Fiyat (₺/m²)', suffixText: '₺', prefixIcon: Icon(Icons.monetization_on)),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculateMaterial(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Toplam:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(_currencyFormat.format(_totalMaterial), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _calculateProfit() {
    final cost = double.tryParse(_costController.text) ?? 0;
    final rate = double.tryParse(_profitRateController.text) ?? 0;
    setState(() {
      _profit = cost * (rate / 100);
      _salePrice = cost + _profit;
    });
  }

  void _calculateMaterial() {
    final m2 = double.tryParse(_m2Controller.text) ?? 0;
    final price = double.tryParse(_pricePerM2Controller.text) ?? 0;
    setState(() {
      _totalMaterial = m2 * price;
    });
  }
}
