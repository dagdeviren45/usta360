import 'package:drift/drift.dart';

/// Müşteri/Firma tablosu
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text().withDefault(const Constant('person'))(); // person/company
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// İş tablosu
class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  TextColumn get title => text().withLength(min: 1, max: 300)();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('draft'))(); // draft/active/pending/completed/cancelled
  TextColumn get location => text().nullable()();
  RealColumn get totalCost => real().withDefault(const Constant(0))();
  RealColumn get totalSale => real().withDefault(const Constant(0))();
  RealColumn get profit => real().withDefault(const Constant(0))();
  RealColumn get profitRate => real().withDefault(const Constant(0))();
  RealColumn get quotedPrice => real().withDefault(const Constant(0))();
  RealColumn get collectedAmount => real().withDefault(const Constant(0))();
  RealColumn get depositAmount => real().withDefault(const Constant(0))();
  RealColumn get customExpense => real().withDefault(const Constant(0))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Kalem/iş kalemi tablosu
class LineItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().references(Jobs, #id)();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get type => text().withDefault(const Constant('material'))(); // material/labor/other
  TextColumn get unit => text().withDefault(const Constant('adet'))();
  RealColumn get quantity => real().withDefault(const Constant(1))();
  RealColumn get costPerUnit => real().withDefault(const Constant(0))();
  RealColumn get salePerUnit => real().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// İş fotoğrafları
class JobImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().references(Jobs, #id)();
  TextColumn get path => text()();
  TextColumn get caption => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Hatırlatıcılar
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().nullable()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get scheduledAt => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get notificationId => integer().withDefault(const Constant(0))();
  TextColumn get priority => text().withDefault(const Constant('normal'))();
  TextColumn get soundType => text().withDefault(const Constant('default'))();
  TextColumn get repeatRule => text().withDefault(const Constant('none'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Uygulama ayarları (tek kayıtlık)
class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get companyName => text().nullable()();
  TextColumn get companyPhone => text().nullable()();
  TextColumn get companyEmail => text().nullable()();
  TextColumn get companyAddress => text().nullable()();
  TextColumn get logoPath => text().nullable()();
  TextColumn get pdfFooterNote => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('TRY'))();
  RealColumn get defaultProfitRate => real().withDefault(const Constant(30))();
  BoolColumn get darkMode => boolean().withDefault(const Constant(true))();
}

/// Malzeme şablonları (hızlı ekleme için)
class MaterialTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get unit => text().withDefault(const Constant('adet'))();
  RealColumn get defaultCost => real().withDefault(const Constant(0))();
  RealColumn get defaultSale => real().withDefault(const Constant(0))();
  TextColumn get category => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Ödemeler tablosu
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().references(Jobs, #id)();
  RealColumn get amount => real()();
  TextColumn get type => text().withDefault(const Constant('payment'))(); // payment/deposit/refund
  TextColumn get method => text().withDefault(const Constant('cash'))(); // cash/card/transfer/other
  TextColumn get notes => text().nullable()();
  DateTimeColumn get paymentDate => dateTime().withDefault(currentDateAndTime)();
  IntColumn get periodId => integer().nullable()();
}

/// Genel gelir/gider işlemleri (işlerden bağımsız)
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  RealColumn get amount => real()();
  TextColumn get type => text().withDefault(const Constant('income'))(); // income/expense
  TextColumn get category => text().nullable()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  IntColumn get periodId => integer().nullable()();
}

/// Bütçe dönemleri
class BudgetPeriods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
