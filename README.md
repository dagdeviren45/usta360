# Usta360 Pro - İş Takip Uygulaması

Usta360, zanaatkarlar, tamirciler ve serbest çalışan ustalar için geliştirilmiş kapsamlı bir iş takip ve yönetim uygulamasıdır.

## 🚀 Özellikler

### 📊 Dashboard
- Günlük özet istatistikler (aktif işler, bekleyenler, tamamlananlar)
- Finansal genel bakış
- Yaklaşan hatırlatıcılar
- Son işler listesi

### 🛠️ İş Yönetimi
- Detaylı iş kaydı (Müşteri, durum, öncelik, tarihler)
- İş kalemleri (Malzeme, İşçilik, Diğer giderler)
- Kâr/Zarar analizi (Otomatik hesaplama)
- Fotoğraf galerisi (İş öncesi/sonrası)
- Süreç takibi (Taslak, Aktif, Beklemede, Tamamlandı, İptal)

### 👥 Müşteri Yönetimi
- Müşteri veritabanı
- İletişim bilgileri ve hızlı arama/mesajlaşma
- Müşteri geçmişi ve bakiye takibi

### 📄 PDF Teklif & Raporlama
- Profesyonel teklif formu oluşturma
- Kurumsal ve minimal şablon seçenekleri
- Logo ve şirket bilgileri entegrasyonu
- PDF önizleme ve paylaşma

### 🔔 Hatırlatıcılar & Bildirimler
- İş bazlı hatırlatıcılar
- Tekrarlayan bildirimler (Günlük, Haftalık, Aylık)
- Öncelik seviyeleri

### 🧮 Araçlar & Hesaplayıcılar
- Kâr hesaplama (Maliyet üzerinden)
- Alan hesaplama (m²)
- İşçilik maliyet hesaplama

### ⚙️ Diğer Özellikler
- **Offline-First**: İnternet olmadan tam fonksiyon çalışır
- **Yedekleme**: Tüm verileri ve fotoğrafları ZIP olarak yedekleme/geri yükleme
- **Tema Desteği**: Açık ve Koyu mod
- **Reklam Entegrasyonu**: AdMob (Banner, Geçiş, Native)

## 🛠️ Kurulum ve Çalıştırma

Bu proje Flutter ile geliştirilmiştir. Çalıştırmak için Flutter SDK kurulu olmalıdır.

1. **Bağımlılıkları Yükleyin**
   ```bash
   flutter pub get
   ```

2. **Veritabanı Kodlarını Oluşturun (Gerekirse)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
   *Not: Bu işlem zaten yapılmıştır.*

3. **Uygulamayı Başlatın**
   ```bash
   flutter run
   ```

## 📱 Android Yapılandırması

- **Minimum SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)
- **İzinler**: Kamera, İnternet, Bildirimler otomatik olarak yapılandırılmıştır.

## 🏗️ Proje Yapısı

- `lib/core`: Veritabanı, servisler, tema ve ortak bileşenler
- `lib/features`: Özellik bazlı modüller (Jobs, Customers, Settings vb.)
- `lib/main.dart`: Uygulama giriş noktası

## 📝 Notlar

- Reklam kimlikleri test amaçlıdır. Canlıya geçmeden önce `AdService` ve `AndroidManifest.xml` içerisindeki ID'leri kendi AdMob ID'lerinizle değiştirin.
- PDF oluştururken şirket logosunu Ayarlar menüsünden ekleyebilirsiniz.

---
**Geliştirici**: Google Deepmind Antigravity Agent
