import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

import '../database/database.dart';


/// PDF servisi provider
final pdfServiceProvider = Provider<PdfService>((ref) => PdfService());

/// PDF şablon tipleri
enum PdfTemplate { minimal, corporate }

/// PDF Servisi - Teklif PDF oluşturma
class PdfService {
  final _currencyFormat = NumberFormat.currency(
    locale: 'tr',
    symbol: '₺',
    decimalDigits: 2,
  );

  /// Teklif PDF'i oluştur
  /// DİKKAT: PDF'te maliyet ve kâr bilgisi ASLA görünmez!
  Future<Uint8List> generateProposalPdf({
    required Job job,
    required Customer customer,
    required List<LineItem> lineItems,
    required AppSetting settings,
    PdfTemplate template = PdfTemplate.minimal,
  }) async {
    final pdf = pw.Document();

    // Font yükleme (Native printing olmadan standart fontlar)
    final font = pw.Font.helvetica();
    final fontBold = pw.Font.helveticaBold();
    final pw.TextStyle defaultStyle = pw.TextStyle(font: font);
    final pw.TextStyle boldStyle = pw.TextStyle(font: fontBold, fontWeight: pw.FontWeight.bold);

    // Logo yükleme
    pw.MemoryImage? logo;
    if (settings.logoPath != null && settings.logoPath!.isNotEmpty) {
      try {
        final logoFile = File(settings.logoPath!);
        if (await logoFile.exists()) {
          final logoBytes = await logoFile.readAsBytes();
          logo = pw.MemoryImage(logoBytes);
        }
      } catch (_) {}
    }

    // Dosya yoksa veya yüklenemediyse varsayılan logoyu (asset) dene
    if (logo == null) {
      try {
        final logoData = await rootBundle.load('assets/images/logo.png');
        logo = pw.MemoryImage(logoData.buffer.asUint8List());
      } catch (_) {}
    }

    // Tarih formatı
    final dateFormat = DateFormat('dd.MM.yyyy', 'tr');
    final now = dateFormat.format(DateTime.now());
    final dueDate = job.dueDate != null ? dateFormat.format(job.dueDate!) : '-';

    // Toplam fiyat (müşteriye gösterilecek)
    double grandTotal = 0;
    for (final item in lineItems) {
      grandTotal += item.salePerUnit * item.quantity;
    }

    if (template == PdfTemplate.corporate) {
      _buildCorporatePdf(
        pdf: pdf,
        job: job,
        customer: customer,
        lineItems: lineItems,
        settings: settings,
        logo: logo,
        now: now,
        dueDate: dueDate,
        grandTotal: grandTotal,
        font: font,
        fontBold: fontBold,
      );
    } else {
      _buildMinimalPdf(
        pdf: pdf,
        job: job,
        customer: customer,
        lineItems: lineItems,
        settings: settings,
        logo: logo,
        now: now,
        dueDate: dueDate,
        grandTotal: grandTotal,
        font: font,
        fontBold: fontBold,
      );
    }

    return pdf.save();
  }

  void _buildMinimalPdf({
    required pw.Document pdf,
    required Job job,
    required Customer customer,
    required List<LineItem> lineItems,
    required AppSetting settings,
    pw.MemoryImage? logo,
    required String now,
    required String dueDate,
    required double grandTotal,
    required pw.Font font,
    required pw.Font fontBold,
  }) {
    final bodyStyle = pw.TextStyle(font: font, fontSize: 10);
    final h1Style = pw.TextStyle(font: fontBold, fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800);
    final headStyle = pw.TextStyle(font: fontBold, fontWeight: pw.FontWeight.bold);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
        ),
        footer: (context) => pw.Column(
          children: [
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 4),
            pw.Center(
              child: pw.Text(
                'Copyright © USTA360. Bu fiyat teklifi USTA360 Uygulaması üzerinden oluşturulmuştur.\nHer hangi bir mesuliyet kabul edilmez, anlaşma firma ile müşteri arasındadır.',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: font,
                  fontSize: 7,
                  color: PdfColors.grey500,
                ),
              ),
            ),
          ],
        ),
        build: (context) => [
          // Header
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (logo != null)
                    pw.Image(logo, width: 60, height: 60)
                  else
                    pw.Text(
                      settings.companyName ?? 'Usta360',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue800,
                      ),
                    ),
                  pw.SizedBox(height: 8),
                  if (settings.companyName != null && logo != null)
                    pw.Text(
                      settings.companyName!,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  if (settings.companyPhone != null)
                    pw.Text(settings.companyPhone!,
                        style: const pw.TextStyle(fontSize: 10)),
                  if (settings.companyEmail != null)
                    pw.Text(settings.companyEmail!,
                        style: const pw.TextStyle(fontSize: 10)),
                  if (settings.companyAddress != null)
                    pw.Text(settings.companyAddress!,
                        style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('TEKLİF',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue800,
                      )),
                  pw.SizedBox(height: 8),
                  pw.Text('Tarih: $now',
                      style: const pw.TextStyle(fontSize: 11)),
                  pw.Text('Teklif No: #${job.id}',
                      style: const pw.TextStyle(fontSize: 11)),
                  if (job.dueDate != null)
                    pw.Text('Teslim Tarihi: $dueDate',
                        style: const pw.TextStyle(fontSize: 11)),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 30),

          // Müşteri bilgileri
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Müşteri / Firma',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    )),
                pw.SizedBox(height: 8),
                pw.Text(customer.name,
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                if (customer.phone != null) pw.Text(customer.phone!),
                if (customer.email != null) pw.Text(customer.email!),
                if (customer.address != null) pw.Text(customer.address!),
              ],
            ),
          ),

          pw.SizedBox(height: 16),

          // İş başlığı
          pw.Text(job.title,
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              )),
          if (job.description != null && job.description!.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(job.description!,
                style: const pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.grey700,
                )),
          ],

          pw.SizedBox(height: 20),

          // Kalem tablosu - SADECE SATIŞ FİYATLARI (maliyet/kâr YOK)
          pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 11,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blue800,
            ),
            headerAlignment: pw.Alignment.centerLeft,
            cellStyle: pw.TextStyle(font: font, fontSize: 10),
            cellAlignment: pw.Alignment.centerLeft,
            cellPadding: const pw.EdgeInsets.all(8),
            headers: ['Kalem', 'Miktar', 'Birim', 'Birim Fiyat', 'Toplam'],
            data: lineItems.map((item) {
              final total = item.salePerUnit * item.quantity;
              return [
                item.name,
                item.quantity.toStringAsFixed(
                    item.quantity == item.quantity.roundToDouble() ? 0 : 2),
                _unitLabel(item.unit),
                _currencyFormat.format(item.salePerUnit),
                _currencyFormat.format(total),
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 16),

          // Toplam
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.blue200),
              ),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text('GENEL TOPLAM:  ',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue900,
                      )),
                  pw.Text(
                    _currencyFormat.format(grandTotal),
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                ],
              ),
            ),
          ),

          pw.SizedBox(height: 30),

          // Dipnot
          if (settings.pdfFooterNote != null &&
              settings.pdfFooterNote!.isNotEmpty) ...[
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 8),
            pw.Text('Notlar:',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 4),
            pw.Text(settings.pdfFooterNote!,
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey700,
                )),
          ],
        ],
      ),
    );
  }

  void _buildCorporatePdf({
    required pw.Document pdf,
    required Job job,
    required Customer customer,
    required List<LineItem> lineItems,
    required AppSetting settings,
    pw.MemoryImage? logo,
    required String now,
    required String dueDate,
    required double grandTotal,
    required pw.Font font,
    required pw.Font fontBold,
  }) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
        ),
        margin: const pw.EdgeInsets.all(32),
        header: (context) => pw.Container(
          padding: const pw.EdgeInsets.only(bottom: 16),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.blue800, width: 3),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              if (logo != null)
                pw.Image(logo, width: 50, height: 50)
              else
                pw.Text(settings.companyName ?? 'Usta360',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    )),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  if (settings.companyPhone != null)
                    pw.Text(settings.companyPhone!,
                        style: const pw.TextStyle(fontSize: 9)),
                  if (settings.companyEmail != null)
                    pw.Text(settings.companyEmail!,
                        style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
            ],
          ),
        ),
        footer: (context) => pw.Column(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.only(top: 8),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  top: pw.BorderSide(color: PdfColors.grey300),
                ),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(settings.companyName ?? 'Usta360',
                      style: const pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey500,
                      )),
                  pw.Text(
                    'Sayfa ${context.pageNumber} / ${context.pagesCount}',
                    style: const pw.TextStyle(
                      fontSize: 8,
                      color: PdfColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Center(
              child: pw.Text(
                'Copyright © USTA360. Bu fiyat teklifi USTA360 Uygulaması üzerinden oluşturulmuştur.\nHer hangi bir mesuliyet kabul edilmez, anlaşma firma ile müşteri arasındadır.',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.grey400,
                ),
              ),
            ),
          ],
        ),
        build: (context) => [
          pw.SizedBox(height: 20),

          // Teklif başlığı
          pw.Center(
            child: pw.Text('TEKLİF FORMU',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue800,
                )),
          ),

          pw.SizedBox(height: 24),

          // Info kutucukları
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('MÜŞTERİ',
                          style: pw.TextStyle(
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue800,
                          )),
                      pw.SizedBox(height: 6),
                      pw.Text(customer.name,
                          style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold)),
                      if (customer.phone != null)
                        pw.Text(customer.phone!,
                            style: const pw.TextStyle(fontSize: 10)),
                      if (customer.email != null)
                        pw.Text(customer.email!,
                            style: const pw.TextStyle(fontSize: 10)),
                      if (customer.address != null)
                        pw.Text(customer.address!,
                            style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(width: 16),
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('TEKLİF DETAY',
                          style: pw.TextStyle(
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue800,
                          )),
                      pw.SizedBox(height: 6),
                      pw.Text('Teklif No: #${job.id}',
                          style: const pw.TextStyle(fontSize: 10)),
                      pw.Text('Tarih: $now',
                          style: const pw.TextStyle(fontSize: 10)),
                      pw.Text('Teslim: $dueDate',
                          style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 20),

          // İş bilgisi
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.blue200),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(job.title,
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                if (job.description != null) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(job.description!,
                      style: const pw.TextStyle(fontSize: 10)),
                ],
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // Kalem tablosu - SADECE MÜŞTERİ FİYATI
          pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(
                color: PdfColors.blue800),
            cellStyle: pw.TextStyle(font: font, fontSize: 9),
            cellPadding: const pw.EdgeInsets.symmetric(
                horizontal: 8, vertical: 6),
            headers: [
              '#',
              'Kalem Adı',
              'Miktar',
              'Birim',
              'Birim Fiyat',
              'Toplam',
            ],
            data: lineItems.asMap().entries.map((entry) {
              final i = entry.key + 1;
              final item = entry.value;
              final total = item.salePerUnit * item.quantity;
              return [
                '$i',
                item.name,
                item.quantity.toStringAsFixed(
                    item.quantity == item.quantity.roundToDouble()
                        ? 0
                        : 2),
                _unitLabel(item.unit),
                _currencyFormat.format(item.salePerUnit),
                _currencyFormat.format(total),
              ];
            }).toList(),
          ),

          pw.SizedBox(height: 16),

          // Toplam alanı
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              width: 200,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue800,
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Column(
                children: [
                  pw.Text('GENEL TOPLAM',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      )),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    _currencyFormat.format(grandTotal),
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          pw.SizedBox(height: 30),

          // Dipnot / şartlar
          if (settings.pdfFooterNote != null &&
              settings.pdfFooterNote!.isNotEmpty) ...[
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.grey200),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('ŞARTLAR VE NOTLAR',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.SizedBox(height: 6),
                  pw.Text(settings.pdfFooterNote!,
                      style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Birim etiketini döndür
  String _unitLabel(String unit) {
    switch (unit) {
      case 'adet':
        return 'Adet';
      case 'metre':
        return 'Metre';
      case 'm2':
        return 'm²';
      case 'kg':
        return 'Kg';
      case 'saat':
        return 'Saat';
      case 'lt':
        return 'Lt';
      case 'paket':
        return 'Paket';
      default:
        return unit;
    }
  }

  /// PDF'i dosyaya kaydet
  Future<File> savePdfToFile(Uint8List pdfBytes, int jobId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final pdfDir = Directory(p.join(appDir.path, 'pdf'));
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }

    final fileName = 'teklif_${jobId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(p.join(pdfDir.path, fileName));
    await file.writeAsBytes(pdfBytes);
    return file;
  }

  /// PDF paylaş (share_plus kullanarak)
  Future<void> sharePdf(Uint8List? pdfBytes, String jobTitle) async {
    try {
      if (pdfBytes == null || pdfBytes.isEmpty) {
        throw Exception('Paylaşılacak PDF verisi boş.');
      }
      
      final appDir = await getTemporaryDirectory();
      final fileName = 'Teklif_${jobTitle.replaceAll(' ', '_')}.pdf';
      final file = File(p.join(appDir.path, fileName));
      await file.writeAsBytes(pdfBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: '$jobTitle - Fiyat Teklifi',
      );
    } catch (e) {
      debugPrint('PDF Paylaşma Hatası: $e');
      rethrow;
    }
  }

  /// PDF yazdır (share_plus üzerinden paylaşım menüsü ile yapılır)
  Future<void> printPdf(Uint8List? pdfBytes, String jobTitle) async {
    await sharePdf(pdfBytes, jobTitle);
  }

  /// PDF önizleme (Artık PdfPreview widget'ı olmadığı için direkt paylaşıyoruz)
  Future<void> previewPdf(BuildContext context, Uint8List? pdfBytes, String jobTitle) async {
    if (pdfBytes == null || pdfBytes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hata: PDF verisi oluşturulamadı.')),
      );
      return;
    }

    // Kullanıcıya bilgi verip paylaşımı başlat
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('PDF Oluşturuldu'),
        content: const Text('Teklif PDF\'i başarıyla hazırlandı. Paylaşmak veya yazdırmak ister misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              sharePdf(pdfBytes, jobTitle);
            },
            icon: const Icon(Icons.share),
            label: const Text('Paylaş / Yazdır'),
          ),
        ],
      ),
    );
  }
}
