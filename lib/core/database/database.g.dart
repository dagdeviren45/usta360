// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('person'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        name,
        phone,
        email,
        address,
        notes,
        tags,
        createdAt,
        updatedAt,
        isDeleted,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String type;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? notes;
  final String tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final DateTime? deletedAt;
  const Customer(
      {required this.id,
      required this.type,
      required this.name,
      this.phone,
      this.email,
      this.address,
      this.notes,
      required this.tags,
      required this.createdAt,
      required this.updatedAt,
      required this.isDeleted,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      tags: Value(tags),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Customer copyWith(
          {int? id,
          String? type,
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? tags,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isDeleted,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Customer(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        notes: notes.present ? notes.value : this.notes,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, name, phone, email, address, notes,
      tags, createdAt, updatedAt, isDeleted, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<String> tags;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<DateTime?> deletedAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<String>? tags,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<String?>? notes,
      Value<String>? tags,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isDeleted,
      Value<DateTime?>? deletedAt}) {
    return CustomersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $JobsTable extends Jobs with TableInfo<$JobsTable, Job> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 300),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalCostMeta =
      const VerificationMeta('totalCost');
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
      'total_cost', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalSaleMeta =
      const VerificationMeta('totalSale');
  @override
  late final GeneratedColumn<double> totalSale = GeneratedColumn<double>(
      'total_sale', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _profitMeta = const VerificationMeta('profit');
  @override
  late final GeneratedColumn<double> profit = GeneratedColumn<double>(
      'profit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _profitRateMeta =
      const VerificationMeta('profitRate');
  @override
  late final GeneratedColumn<double> profitRate = GeneratedColumn<double>(
      'profit_rate', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _quotedPriceMeta =
      const VerificationMeta('quotedPrice');
  @override
  late final GeneratedColumn<double> quotedPrice = GeneratedColumn<double>(
      'quoted_price', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _depositAmountMeta =
      const VerificationMeta('depositAmount');
  @override
  late final GeneratedColumn<double> depositAmount = GeneratedColumn<double>(
      'deposit_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _collectedAmountMeta =
      const VerificationMeta('collectedAmount');
  @override
  late final GeneratedColumn<double> collectedAmount = GeneratedColumn<double>(
      'collected_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _customExpenseMeta =
      const VerificationMeta('customExpense');
  @override
  late final GeneratedColumn<double> customExpense = GeneratedColumn<double>(
      'custom_expense', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _pdfSentMeta =
      const VerificationMeta('pdfSent');
  @override
  late final GeneratedColumn<bool> pdfSent = GeneratedColumn<bool>(
      'pdf_sent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pdf_sent" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _pdfSentAtMeta =
      const VerificationMeta('pdfSentAt');
  @override
  late final GeneratedColumn<DateTime> pdfSentAt = GeneratedColumn<DateTime>(
      'pdf_sent_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        title,
        description,
        status,
        createdAt,
        dueDate,
        location,
        notes,
        totalCost,
        totalSale,
        profit,
        profitRate,
        quotedPrice,
        depositAmount,
        collectedAmount,
        customExpense,
        pdfSent,
        pdfSentAt,
        isDeleted,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(Insertable<Job> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('total_cost')) {
      context.handle(_totalCostMeta,
          totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta));
    }
    if (data.containsKey('total_sale')) {
      context.handle(_totalSaleMeta,
          totalSale.isAcceptableOrUnknown(data['total_sale']!, _totalSaleMeta));
    }
    if (data.containsKey('profit')) {
      context.handle(_profitMeta,
          profit.isAcceptableOrUnknown(data['profit']!, _profitMeta));
    }
    if (data.containsKey('profit_rate')) {
      context.handle(
          _profitRateMeta,
          profitRate.isAcceptableOrUnknown(
              data['profit_rate']!, _profitRateMeta));
    }
    if (data.containsKey('quoted_price')) {
      context.handle(
          _quotedPriceMeta,
          quotedPrice.isAcceptableOrUnknown(
              data['quoted_price']!, _quotedPriceMeta));
    }
    if (data.containsKey('deposit_amount')) {
      context.handle(
          _depositAmountMeta,
          depositAmount.isAcceptableOrUnknown(
              data['deposit_amount']!, _depositAmountMeta));
    }
    if (data.containsKey('collected_amount')) {
      context.handle(
          _collectedAmountMeta,
          collectedAmount.isAcceptableOrUnknown(
              data['collected_amount']!, _collectedAmountMeta));
    }
    if (data.containsKey('custom_expense')) {
      context.handle(
          _customExpenseMeta,
          customExpense.isAcceptableOrUnknown(
              data['custom_expense']!, _customExpenseMeta));
    }
    if (data.containsKey('pdf_sent')) {
      context.handle(_pdfSentMeta,
          pdfSent.isAcceptableOrUnknown(data['pdf_sent']!, _pdfSentMeta));
    }
    if (data.containsKey('pdf_sent_at')) {
      context.handle(
          _pdfSentAtMeta,
          pdfSentAt.isAcceptableOrUnknown(
              data['pdf_sent_at']!, _pdfSentAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Job map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Job(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      totalCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_cost'])!,
      totalSale: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_sale'])!,
      profit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}profit'])!,
      profitRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}profit_rate'])!,
      quotedPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quoted_price'])!,
      depositAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}deposit_amount'])!,
      collectedAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}collected_amount'])!,
      customExpense: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}custom_expense'])!,
      pdfSent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pdf_sent'])!,
      pdfSentAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}pdf_sent_at']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }
}

class Job extends DataClass implements Insertable<Job> {
  final int id;
  final int customerId;
  final String title;
  final String? description;
  final String status;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String? location;
  final String? notes;
  final double totalCost;
  final double totalSale;
  final double profit;
  final double profitRate;
  final double quotedPrice;
  final double depositAmount;
  final double collectedAmount;
  final double customExpense;
  final bool pdfSent;
  final DateTime? pdfSentAt;
  final bool isDeleted;
  final DateTime? deletedAt;
  const Job(
      {required this.id,
      required this.customerId,
      required this.title,
      this.description,
      required this.status,
      required this.createdAt,
      this.dueDate,
      this.location,
      this.notes,
      required this.totalCost,
      required this.totalSale,
      required this.profit,
      required this.profitRate,
      required this.quotedPrice,
      required this.depositAmount,
      required this.collectedAmount,
      required this.customExpense,
      required this.pdfSent,
      this.pdfSentAt,
      required this.isDeleted,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['total_cost'] = Variable<double>(totalCost);
    map['total_sale'] = Variable<double>(totalSale);
    map['profit'] = Variable<double>(profit);
    map['profit_rate'] = Variable<double>(profitRate);
    map['quoted_price'] = Variable<double>(quotedPrice);
    map['deposit_amount'] = Variable<double>(depositAmount);
    map['collected_amount'] = Variable<double>(collectedAmount);
    map['custom_expense'] = Variable<double>(customExpense);
    map['pdf_sent'] = Variable<bool>(pdfSent);
    if (!nullToAbsent || pdfSentAt != null) {
      map['pdf_sent_at'] = Variable<DateTime>(pdfSentAt);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      createdAt: Value(createdAt),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      totalCost: Value(totalCost),
      totalSale: Value(totalSale),
      profit: Value(profit),
      profitRate: Value(profitRate),
      quotedPrice: Value(quotedPrice),
      depositAmount: Value(depositAmount),
      collectedAmount: Value(collectedAmount),
      customExpense: Value(customExpense),
      pdfSent: Value(pdfSent),
      pdfSentAt: pdfSentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfSentAt),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Job.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Job(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      location: serializer.fromJson<String?>(json['location']),
      notes: serializer.fromJson<String?>(json['notes']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      totalSale: serializer.fromJson<double>(json['totalSale']),
      profit: serializer.fromJson<double>(json['profit']),
      profitRate: serializer.fromJson<double>(json['profitRate']),
      quotedPrice: serializer.fromJson<double>(json['quotedPrice']),
      depositAmount: serializer.fromJson<double>(json['depositAmount']),
      collectedAmount: serializer.fromJson<double>(json['collectedAmount']),
      customExpense: serializer.fromJson<double>(json['customExpense']),
      pdfSent: serializer.fromJson<bool>(json['pdfSent']),
      pdfSentAt: serializer.fromJson<DateTime?>(json['pdfSentAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'location': serializer.toJson<String?>(location),
      'notes': serializer.toJson<String?>(notes),
      'totalCost': serializer.toJson<double>(totalCost),
      'totalSale': serializer.toJson<double>(totalSale),
      'profit': serializer.toJson<double>(profit),
      'profitRate': serializer.toJson<double>(profitRate),
      'quotedPrice': serializer.toJson<double>(quotedPrice),
      'depositAmount': serializer.toJson<double>(depositAmount),
      'collectedAmount': serializer.toJson<double>(collectedAmount),
      'customExpense': serializer.toJson<double>(customExpense),
      'pdfSent': serializer.toJson<bool>(pdfSent),
      'pdfSentAt': serializer.toJson<DateTime?>(pdfSentAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Job copyWith(
          {int? id,
          int? customerId,
          String? title,
          Value<String?> description = const Value.absent(),
          String? status,
          DateTime? createdAt,
          Value<DateTime?> dueDate = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          double? totalCost,
          double? totalSale,
          double? profit,
          double? profitRate,
          double? quotedPrice,
          double? depositAmount,
          double? collectedAmount,
          double? customExpense,
          bool? pdfSent,
          Value<DateTime?> pdfSentAt = const Value.absent(),
          bool? isDeleted,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Job(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        location: location.present ? location.value : this.location,
        notes: notes.present ? notes.value : this.notes,
        totalCost: totalCost ?? this.totalCost,
        totalSale: totalSale ?? this.totalSale,
        profit: profit ?? this.profit,
        profitRate: profitRate ?? this.profitRate,
        quotedPrice: quotedPrice ?? this.quotedPrice,
        depositAmount: depositAmount ?? this.depositAmount,
        collectedAmount: collectedAmount ?? this.collectedAmount,
        customExpense: customExpense ?? this.customExpense,
        pdfSent: pdfSent ?? this.pdfSent,
        pdfSentAt: pdfSentAt.present ? pdfSentAt.value : this.pdfSentAt,
        isDeleted: isDeleted ?? this.isDeleted,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Job copyWithCompanion(JobsCompanion data) {
    return Job(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      location: data.location.present ? data.location.value : this.location,
      notes: data.notes.present ? data.notes.value : this.notes,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      totalSale: data.totalSale.present ? data.totalSale.value : this.totalSale,
      profit: data.profit.present ? data.profit.value : this.profit,
      profitRate:
          data.profitRate.present ? data.profitRate.value : this.profitRate,
      quotedPrice:
          data.quotedPrice.present ? data.quotedPrice.value : this.quotedPrice,
      depositAmount: data.depositAmount.present
          ? data.depositAmount.value
          : this.depositAmount,
      collectedAmount: data.collectedAmount.present
          ? data.collectedAmount.value
          : this.collectedAmount,
      customExpense: data.customExpense.present
          ? data.customExpense.value
          : this.customExpense,
      pdfSent: data.pdfSent.present ? data.pdfSent.value : this.pdfSent,
      pdfSentAt: data.pdfSentAt.present ? data.pdfSentAt.value : this.pdfSentAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Job(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('dueDate: $dueDate, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('totalCost: $totalCost, ')
          ..write('totalSale: $totalSale, ')
          ..write('profit: $profit, ')
          ..write('profitRate: $profitRate, ')
          ..write('quotedPrice: $quotedPrice, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('collectedAmount: $collectedAmount, ')
          ..write('customExpense: $customExpense, ')
          ..write('pdfSent: $pdfSent, ')
          ..write('pdfSentAt: $pdfSentAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        customerId,
        title,
        description,
        status,
        createdAt,
        dueDate,
        location,
        notes,
        totalCost,
        totalSale,
        profit,
        profitRate,
        quotedPrice,
        depositAmount,
        collectedAmount,
        customExpense,
        pdfSent,
        pdfSentAt,
        isDeleted,
        deletedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Job &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.dueDate == this.dueDate &&
          other.location == this.location &&
          other.notes == this.notes &&
          other.totalCost == this.totalCost &&
          other.totalSale == this.totalSale &&
          other.profit == this.profit &&
          other.profitRate == this.profitRate &&
          other.quotedPrice == this.quotedPrice &&
          other.depositAmount == this.depositAmount &&
          other.collectedAmount == this.collectedAmount &&
          other.customExpense == this.customExpense &&
          other.pdfSent == this.pdfSent &&
          other.pdfSentAt == this.pdfSentAt &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt);
}

class JobsCompanion extends UpdateCompanion<Job> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> dueDate;
  final Value<String?> location;
  final Value<String?> notes;
  final Value<double> totalCost;
  final Value<double> totalSale;
  final Value<double> profit;
  final Value<double> profitRate;
  final Value<double> quotedPrice;
  final Value<double> depositAmount;
  final Value<double> collectedAmount;
  final Value<double> customExpense;
  final Value<bool> pdfSent;
  final Value<DateTime?> pdfSentAt;
  final Value<bool> isDeleted;
  final Value<DateTime?> deletedAt;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.totalSale = const Value.absent(),
    this.profit = const Value.absent(),
    this.profitRate = const Value.absent(),
    this.quotedPrice = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.collectedAmount = const Value.absent(),
    this.customExpense = const Value.absent(),
    this.pdfSent = const Value.absent(),
    this.pdfSentAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  JobsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String title,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.totalSale = const Value.absent(),
    this.profit = const Value.absent(),
    this.profitRate = const Value.absent(),
    this.quotedPrice = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.collectedAmount = const Value.absent(),
    this.customExpense = const Value.absent(),
    this.pdfSent = const Value.absent(),
    this.pdfSentAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : customerId = Value(customerId),
        title = Value(title);
  static Insertable<Job> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? dueDate,
    Expression<String>? location,
    Expression<String>? notes,
    Expression<double>? totalCost,
    Expression<double>? totalSale,
    Expression<double>? profit,
    Expression<double>? profitRate,
    Expression<double>? quotedPrice,
    Expression<double>? depositAmount,
    Expression<double>? collectedAmount,
    Expression<double>? customExpense,
    Expression<bool>? pdfSent,
    Expression<DateTime>? pdfSentAt,
    Expression<bool>? isDeleted,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (dueDate != null) 'due_date': dueDate,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      if (totalCost != null) 'total_cost': totalCost,
      if (totalSale != null) 'total_sale': totalSale,
      if (profit != null) 'profit': profit,
      if (profitRate != null) 'profit_rate': profitRate,
      if (quotedPrice != null) 'quoted_price': quotedPrice,
      if (depositAmount != null) 'deposit_amount': depositAmount,
      if (collectedAmount != null) 'collected_amount': collectedAmount,
      if (customExpense != null) 'custom_expense': customExpense,
      if (pdfSent != null) 'pdf_sent': pdfSent,
      if (pdfSentAt != null) 'pdf_sent_at': pdfSentAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  JobsCompanion copyWith(
      {Value<int>? id,
      Value<int>? customerId,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime?>? dueDate,
      Value<String?>? location,
      Value<String?>? notes,
      Value<double>? totalCost,
      Value<double>? totalSale,
      Value<double>? profit,
      Value<double>? profitRate,
      Value<double>? quotedPrice,
      Value<double>? depositAmount,
      Value<double>? collectedAmount,
      Value<double>? customExpense,
      Value<bool>? pdfSent,
      Value<DateTime?>? pdfSentAt,
      Value<bool>? isDeleted,
      Value<DateTime?>? deletedAt}) {
    return JobsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      totalCost: totalCost ?? this.totalCost,
      totalSale: totalSale ?? this.totalSale,
      profit: profit ?? this.profit,
      profitRate: profitRate ?? this.profitRate,
      quotedPrice: quotedPrice ?? this.quotedPrice,
      depositAmount: depositAmount ?? this.depositAmount,
      collectedAmount: collectedAmount ?? this.collectedAmount,
      customExpense: customExpense ?? this.customExpense,
      pdfSent: pdfSent ?? this.pdfSent,
      pdfSentAt: pdfSentAt ?? this.pdfSentAt,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (totalSale.present) {
      map['total_sale'] = Variable<double>(totalSale.value);
    }
    if (profit.present) {
      map['profit'] = Variable<double>(profit.value);
    }
    if (profitRate.present) {
      map['profit_rate'] = Variable<double>(profitRate.value);
    }
    if (quotedPrice.present) {
      map['quoted_price'] = Variable<double>(quotedPrice.value);
    }
    if (depositAmount.present) {
      map['deposit_amount'] = Variable<double>(depositAmount.value);
    }
    if (collectedAmount.present) {
      map['collected_amount'] = Variable<double>(collectedAmount.value);
    }
    if (customExpense.present) {
      map['custom_expense'] = Variable<double>(customExpense.value);
    }
    if (pdfSent.present) {
      map['pdf_sent'] = Variable<bool>(pdfSent.value);
    }
    if (pdfSentAt.present) {
      map['pdf_sent_at'] = Variable<DateTime>(pdfSentAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('dueDate: $dueDate, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('totalCost: $totalCost, ')
          ..write('totalSale: $totalSale, ')
          ..write('profit: $profit, ')
          ..write('profitRate: $profitRate, ')
          ..write('quotedPrice: $quotedPrice, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('collectedAmount: $collectedAmount, ')
          ..write('customExpense: $customExpense, ')
          ..write('pdfSent: $pdfSent, ')
          ..write('pdfSentAt: $pdfSentAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $LineItemsTable extends LineItems
    with TableInfo<$LineItemsTable, LineItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LineItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
      'job_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES jobs (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('material'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 300),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('adet'));
  static const VerificationMeta _costPerUnitMeta =
      const VerificationMeta('costPerUnit');
  @override
  late final GeneratedColumn<double> costPerUnit = GeneratedColumn<double>(
      'cost_per_unit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _salePerUnitMeta =
      const VerificationMeta('salePerUnit');
  @override
  late final GeneratedColumn<double> salePerUnit = GeneratedColumn<double>(
      'sale_per_unit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _taxModeMeta =
      const VerificationMeta('taxMode');
  @override
  late final GeneratedColumn<String> taxMode = GeneratedColumn<String>(
      'tax_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('included'));
  static const VerificationMeta _supplierNoteMeta =
      const VerificationMeta('supplierNote');
  @override
  late final GeneratedColumn<String> supplierNote = GeneratedColumn<String>(
      'supplier_note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        jobId,
        type,
        name,
        description,
        quantity,
        unit,
        costPerUnit,
        salePerUnit,
        taxMode,
        supplierNote,
        sortOrder,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'line_items';
  @override
  VerificationContext validateIntegrity(Insertable<LineItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('cost_per_unit')) {
      context.handle(
          _costPerUnitMeta,
          costPerUnit.isAcceptableOrUnknown(
              data['cost_per_unit']!, _costPerUnitMeta));
    }
    if (data.containsKey('sale_per_unit')) {
      context.handle(
          _salePerUnitMeta,
          salePerUnit.isAcceptableOrUnknown(
              data['sale_per_unit']!, _salePerUnitMeta));
    }
    if (data.containsKey('tax_mode')) {
      context.handle(_taxModeMeta,
          taxMode.isAcceptableOrUnknown(data['tax_mode']!, _taxModeMeta));
    }
    if (data.containsKey('supplier_note')) {
      context.handle(
          _supplierNoteMeta,
          supplierNote.isAcceptableOrUnknown(
              data['supplier_note']!, _supplierNoteMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LineItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LineItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}job_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      costPerUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_per_unit'])!,
      salePerUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sale_per_unit'])!,
      taxMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_mode'])!,
      supplierNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_note']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LineItemsTable createAlias(String alias) {
    return $LineItemsTable(attachedDatabase, alias);
  }
}

class LineItem extends DataClass implements Insertable<LineItem> {
  final int id;
  final int jobId;
  final String type;
  final String name;
  final String? description;
  final double quantity;
  final String unit;
  final double costPerUnit;
  final double salePerUnit;
  final String taxMode;
  final String? supplierNote;
  final int sortOrder;
  final DateTime createdAt;
  const LineItem(
      {required this.id,
      required this.jobId,
      required this.type,
      required this.name,
      this.description,
      required this.quantity,
      required this.unit,
      required this.costPerUnit,
      required this.salePerUnit,
      required this.taxMode,
      this.supplierNote,
      required this.sortOrder,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    map['cost_per_unit'] = Variable<double>(costPerUnit);
    map['sale_per_unit'] = Variable<double>(salePerUnit);
    map['tax_mode'] = Variable<String>(taxMode);
    if (!nullToAbsent || supplierNote != null) {
      map['supplier_note'] = Variable<String>(supplierNote);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LineItemsCompanion toCompanion(bool nullToAbsent) {
    return LineItemsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      type: Value(type),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      quantity: Value(quantity),
      unit: Value(unit),
      costPerUnit: Value(costPerUnit),
      salePerUnit: Value(salePerUnit),
      taxMode: Value(taxMode),
      supplierNote: supplierNote == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierNote),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory LineItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LineItem(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      costPerUnit: serializer.fromJson<double>(json['costPerUnit']),
      salePerUnit: serializer.fromJson<double>(json['salePerUnit']),
      taxMode: serializer.fromJson<String>(json['taxMode']),
      supplierNote: serializer.fromJson<String?>(json['supplierNote']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'costPerUnit': serializer.toJson<double>(costPerUnit),
      'salePerUnit': serializer.toJson<double>(salePerUnit),
      'taxMode': serializer.toJson<String>(taxMode),
      'supplierNote': serializer.toJson<String?>(supplierNote),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LineItem copyWith(
          {int? id,
          int? jobId,
          String? type,
          String? name,
          Value<String?> description = const Value.absent(),
          double? quantity,
          String? unit,
          double? costPerUnit,
          double? salePerUnit,
          String? taxMode,
          Value<String?> supplierNote = const Value.absent(),
          int? sortOrder,
          DateTime? createdAt}) =>
      LineItem(
        id: id ?? this.id,
        jobId: jobId ?? this.jobId,
        type: type ?? this.type,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        costPerUnit: costPerUnit ?? this.costPerUnit,
        salePerUnit: salePerUnit ?? this.salePerUnit,
        taxMode: taxMode ?? this.taxMode,
        supplierNote:
            supplierNote.present ? supplierNote.value : this.supplierNote,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
      );
  LineItem copyWithCompanion(LineItemsCompanion data) {
    return LineItem(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      costPerUnit:
          data.costPerUnit.present ? data.costPerUnit.value : this.costPerUnit,
      salePerUnit:
          data.salePerUnit.present ? data.salePerUnit.value : this.salePerUnit,
      taxMode: data.taxMode.present ? data.taxMode.value : this.taxMode,
      supplierNote: data.supplierNote.present
          ? data.supplierNote.value
          : this.supplierNote,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LineItem(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('salePerUnit: $salePerUnit, ')
          ..write('taxMode: $taxMode, ')
          ..write('supplierNote: $supplierNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      jobId,
      type,
      name,
      description,
      quantity,
      unit,
      costPerUnit,
      salePerUnit,
      taxMode,
      supplierNote,
      sortOrder,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LineItem &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.type == this.type &&
          other.name == this.name &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.costPerUnit == this.costPerUnit &&
          other.salePerUnit == this.salePerUnit &&
          other.taxMode == this.taxMode &&
          other.supplierNote == this.supplierNote &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class LineItemsCompanion extends UpdateCompanion<LineItem> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<double> costPerUnit;
  final Value<double> salePerUnit;
  final Value<String> taxMode;
  final Value<String?> supplierNote;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const LineItemsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.costPerUnit = const Value.absent(),
    this.salePerUnit = const Value.absent(),
    this.taxMode = const Value.absent(),
    this.supplierNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LineItemsCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    this.type = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.costPerUnit = const Value.absent(),
    this.salePerUnit = const Value.absent(),
    this.taxMode = const Value.absent(),
    this.supplierNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : jobId = Value(jobId),
        name = Value(name);
  static Insertable<LineItem> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<double>? costPerUnit,
    Expression<double>? salePerUnit,
    Expression<String>? taxMode,
    Expression<String>? supplierNote,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (costPerUnit != null) 'cost_per_unit': costPerUnit,
      if (salePerUnit != null) 'sale_per_unit': salePerUnit,
      if (taxMode != null) 'tax_mode': taxMode,
      if (supplierNote != null) 'supplier_note': supplierNote,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LineItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? jobId,
      Value<String>? type,
      Value<String>? name,
      Value<String?>? description,
      Value<double>? quantity,
      Value<String>? unit,
      Value<double>? costPerUnit,
      Value<double>? salePerUnit,
      Value<String>? taxMode,
      Value<String?>? supplierNote,
      Value<int>? sortOrder,
      Value<DateTime>? createdAt}) {
    return LineItemsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      salePerUnit: salePerUnit ?? this.salePerUnit,
      taxMode: taxMode ?? this.taxMode,
      supplierNote: supplierNote ?? this.supplierNote,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (costPerUnit.present) {
      map['cost_per_unit'] = Variable<double>(costPerUnit.value);
    }
    if (salePerUnit.present) {
      map['sale_per_unit'] = Variable<double>(salePerUnit.value);
    }
    if (taxMode.present) {
      map['tax_mode'] = Variable<String>(taxMode.value);
    }
    if (supplierNote.present) {
      map['supplier_note'] = Variable<String>(supplierNote.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LineItemsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('salePerUnit: $salePerUnit, ')
          ..write('taxMode: $taxMode, ')
          ..write('supplierNote: $supplierNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
      'job_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES jobs (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scheduledAtMeta =
      const VerificationMeta('scheduledAt');
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
      'scheduled_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _repeatRuleMeta =
      const VerificationMeta('repeatRule');
  @override
  late final GeneratedColumn<String> repeatRule = GeneratedColumn<String>(
      'repeat_rule', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
      'notification_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('normal'));
  static const VerificationMeta _soundTypeMeta =
      const VerificationMeta('soundType');
  @override
  late final GeneratedColumn<String> soundType = GeneratedColumn<String>(
      'sound_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        jobId,
        title,
        description,
        scheduledAt,
        repeatRule,
        notificationId,
        enabled,
        isCompleted,
        priority,
        soundType,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<Reminder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
          _scheduledAtMeta,
          scheduledAt.isAcceptableOrUnknown(
              data['scheduled_at']!, _scheduledAtMeta));
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('repeat_rule')) {
      context.handle(
          _repeatRuleMeta,
          repeatRule.isAcceptableOrUnknown(
              data['repeat_rule']!, _repeatRuleMeta));
    }
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id']!, _notificationIdMeta));
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('sound_type')) {
      context.handle(_soundTypeMeta,
          soundType.isAcceptableOrUnknown(data['sound_type']!, _soundTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}job_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      scheduledAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_at'])!,
      repeatRule: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repeat_rule']),
      notificationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notification_id'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      soundType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sound_type']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final int jobId;
  final String title;
  final String? description;
  final DateTime scheduledAt;
  final String? repeatRule;
  final int notificationId;
  final bool enabled;
  final bool isCompleted;
  final String priority;
  final String? soundType;
  final DateTime createdAt;
  const Reminder(
      {required this.id,
      required this.jobId,
      required this.title,
      this.description,
      required this.scheduledAt,
      this.repeatRule,
      required this.notificationId,
      required this.enabled,
      required this.isCompleted,
      required this.priority,
      this.soundType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    if (!nullToAbsent || repeatRule != null) {
      map['repeat_rule'] = Variable<String>(repeatRule);
    }
    map['notification_id'] = Variable<int>(notificationId);
    map['enabled'] = Variable<bool>(enabled);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || soundType != null) {
      map['sound_type'] = Variable<String>(soundType);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      jobId: Value(jobId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      scheduledAt: Value(scheduledAt),
      repeatRule: repeatRule == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatRule),
      notificationId: Value(notificationId),
      enabled: Value(enabled),
      isCompleted: Value(isCompleted),
      priority: Value(priority),
      soundType: soundType == null && nullToAbsent
          ? const Value.absent()
          : Value(soundType),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      repeatRule: serializer.fromJson<String?>(json['repeatRule']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      priority: serializer.fromJson<String>(json['priority']),
      soundType: serializer.fromJson<String?>(json['soundType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'repeatRule': serializer.toJson<String?>(repeatRule),
      'notificationId': serializer.toJson<int>(notificationId),
      'enabled': serializer.toJson<bool>(enabled),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'priority': serializer.toJson<String>(priority),
      'soundType': serializer.toJson<String?>(soundType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith(
          {int? id,
          int? jobId,
          String? title,
          Value<String?> description = const Value.absent(),
          DateTime? scheduledAt,
          Value<String?> repeatRule = const Value.absent(),
          int? notificationId,
          bool? enabled,
          bool? isCompleted,
          String? priority,
          Value<String?> soundType = const Value.absent(),
          DateTime? createdAt}) =>
      Reminder(
        id: id ?? this.id,
        jobId: jobId ?? this.jobId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        scheduledAt: scheduledAt ?? this.scheduledAt,
        repeatRule: repeatRule.present ? repeatRule.value : this.repeatRule,
        notificationId: notificationId ?? this.notificationId,
        enabled: enabled ?? this.enabled,
        isCompleted: isCompleted ?? this.isCompleted,
        priority: priority ?? this.priority,
        soundType: soundType.present ? soundType.value : this.soundType,
        createdAt: createdAt ?? this.createdAt,
      );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      scheduledAt:
          data.scheduledAt.present ? data.scheduledAt.value : this.scheduledAt,
      repeatRule:
          data.repeatRule.present ? data.repeatRule.value : this.repeatRule,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      priority: data.priority.present ? data.priority.value : this.priority,
      soundType: data.soundType.present ? data.soundType.value : this.soundType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('repeatRule: $repeatRule, ')
          ..write('notificationId: $notificationId, ')
          ..write('enabled: $enabled, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('priority: $priority, ')
          ..write('soundType: $soundType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      jobId,
      title,
      description,
      scheduledAt,
      repeatRule,
      notificationId,
      enabled,
      isCompleted,
      priority,
      soundType,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.title == this.title &&
          other.description == this.description &&
          other.scheduledAt == this.scheduledAt &&
          other.repeatRule == this.repeatRule &&
          other.notificationId == this.notificationId &&
          other.enabled == this.enabled &&
          other.isCompleted == this.isCompleted &&
          other.priority == this.priority &&
          other.soundType == this.soundType &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> scheduledAt;
  final Value<String?> repeatRule;
  final Value<int> notificationId;
  final Value<bool> enabled;
  final Value<bool> isCompleted;
  final Value<String> priority;
  final Value<String?> soundType;
  final Value<DateTime> createdAt;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.repeatRule = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.priority = const Value.absent(),
    this.soundType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    required String title,
    this.description = const Value.absent(),
    required DateTime scheduledAt,
    this.repeatRule = const Value.absent(),
    required int notificationId,
    this.enabled = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.priority = const Value.absent(),
    this.soundType = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : jobId = Value(jobId),
        title = Value(title),
        scheduledAt = Value(scheduledAt),
        notificationId = Value(notificationId);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? scheduledAt,
    Expression<String>? repeatRule,
    Expression<int>? notificationId,
    Expression<bool>? enabled,
    Expression<bool>? isCompleted,
    Expression<String>? priority,
    Expression<String>? soundType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (repeatRule != null) 'repeat_rule': repeatRule,
      if (notificationId != null) 'notification_id': notificationId,
      if (enabled != null) 'enabled': enabled,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (priority != null) 'priority': priority,
      if (soundType != null) 'sound_type': soundType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RemindersCompanion copyWith(
      {Value<int>? id,
      Value<int>? jobId,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime>? scheduledAt,
      Value<String?>? repeatRule,
      Value<int>? notificationId,
      Value<bool>? enabled,
      Value<bool>? isCompleted,
      Value<String>? priority,
      Value<String?>? soundType,
      Value<DateTime>? createdAt}) {
    return RemindersCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      repeatRule: repeatRule ?? this.repeatRule,
      notificationId: notificationId ?? this.notificationId,
      enabled: enabled ?? this.enabled,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      soundType: soundType ?? this.soundType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (repeatRule.present) {
      map['repeat_rule'] = Variable<String>(repeatRule.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (soundType.present) {
      map['sound_type'] = Variable<String>(soundType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('repeatRule: $repeatRule, ')
          ..write('notificationId: $notificationId, ')
          ..write('enabled: $enabled, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('priority: $priority, ')
          ..write('soundType: $soundType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $JobImagesTable extends JobImages
    with TableInfo<$JobImagesTable, JobImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
      'job_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES jobs (id)'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortIndexMeta =
      const VerificationMeta('sortIndex');
  @override
  late final GeneratedColumn<int> sortIndex = GeneratedColumn<int>(
      'sort_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, jobId, path, caption, sortIndex, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_images';
  @override
  VerificationContext validateIntegrity(Insertable<JobImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    }
    if (data.containsKey('sort_index')) {
      context.handle(_sortIndexMeta,
          sortIndex.isAcceptableOrUnknown(data['sort_index']!, _sortIndexMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}job_id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption']),
      sortIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_index'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $JobImagesTable createAlias(String alias) {
    return $JobImagesTable(attachedDatabase, alias);
  }
}

class JobImage extends DataClass implements Insertable<JobImage> {
  final int id;
  final int jobId;
  final String path;
  final String? caption;
  final int sortIndex;
  final DateTime createdAt;
  const JobImage(
      {required this.id,
      required this.jobId,
      required this.path,
      this.caption,
      required this.sortIndex,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['sort_index'] = Variable<int>(sortIndex);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JobImagesCompanion toCompanion(bool nullToAbsent) {
    return JobImagesCompanion(
      id: Value(id),
      jobId: Value(jobId),
      path: Value(path),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      sortIndex: Value(sortIndex),
      createdAt: Value(createdAt),
    );
  }

  factory JobImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobImage(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      path: serializer.fromJson<String>(json['path']),
      caption: serializer.fromJson<String?>(json['caption']),
      sortIndex: serializer.fromJson<int>(json['sortIndex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'path': serializer.toJson<String>(path),
      'caption': serializer.toJson<String?>(caption),
      'sortIndex': serializer.toJson<int>(sortIndex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  JobImage copyWith(
          {int? id,
          int? jobId,
          String? path,
          Value<String?> caption = const Value.absent(),
          int? sortIndex,
          DateTime? createdAt}) =>
      JobImage(
        id: id ?? this.id,
        jobId: jobId ?? this.jobId,
        path: path ?? this.path,
        caption: caption.present ? caption.value : this.caption,
        sortIndex: sortIndex ?? this.sortIndex,
        createdAt: createdAt ?? this.createdAt,
      );
  JobImage copyWithCompanion(JobImagesCompanion data) {
    return JobImage(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      path: data.path.present ? data.path.value : this.path,
      caption: data.caption.present ? data.caption.value : this.caption,
      sortIndex: data.sortIndex.present ? data.sortIndex.value : this.sortIndex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobImage(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('path: $path, ')
          ..write('caption: $caption, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, jobId, path, caption, sortIndex, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobImage &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.path == this.path &&
          other.caption == this.caption &&
          other.sortIndex == this.sortIndex &&
          other.createdAt == this.createdAt);
}

class JobImagesCompanion extends UpdateCompanion<JobImage> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<String> path;
  final Value<String?> caption;
  final Value<int> sortIndex;
  final Value<DateTime> createdAt;
  const JobImagesCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.path = const Value.absent(),
    this.caption = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  JobImagesCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    required String path,
    this.caption = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : jobId = Value(jobId),
        path = Value(path);
  static Insertable<JobImage> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<String>? path,
    Expression<String>? caption,
    Expression<int>? sortIndex,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (path != null) 'path': path,
      if (caption != null) 'caption': caption,
      if (sortIndex != null) 'sort_index': sortIndex,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  JobImagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? jobId,
      Value<String>? path,
      Value<String?>? caption,
      Value<int>? sortIndex,
      Value<DateTime>? createdAt}) {
    return JobImagesCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      path: path ?? this.path,
      caption: caption ?? this.caption,
      sortIndex: sortIndex ?? this.sortIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (sortIndex.present) {
      map['sort_index'] = Variable<int>(sortIndex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobImagesCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('path: $path, ')
          ..write('caption: $caption, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
      'theme_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('dark'));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('TRY'));
  static const VerificationMeta _defaultProfitMarginMeta =
      const VerificationMeta('defaultProfitMargin');
  @override
  late final GeneratedColumn<double> defaultProfitMargin =
      GeneratedColumn<double>('default_profit_margin', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(20.0));
  static const VerificationMeta _pdfTemplateMeta =
      const VerificationMeta('pdfTemplate');
  @override
  late final GeneratedColumn<String> pdfTemplate = GeneratedColumn<String>(
      'pdf_template', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('minimal'));
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyAddressMeta =
      const VerificationMeta('companyAddress');
  @override
  late final GeneratedColumn<String> companyAddress = GeneratedColumn<String>(
      'company_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyPhoneMeta =
      const VerificationMeta('companyPhone');
  @override
  late final GeneratedColumn<String> companyPhone = GeneratedColumn<String>(
      'company_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyEmailMeta =
      const VerificationMeta('companyEmail');
  @override
  late final GeneratedColumn<String> companyEmail = GeneratedColumn<String>(
      'company_email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoPathMeta =
      const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
      'logo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pdfFooterNoteMeta =
      const VerificationMeta('pdfFooterNote');
  @override
  late final GeneratedColumn<String> pdfFooterNote = GeneratedColumn<String>(
      'pdf_footer_note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPremiumMeta =
      const VerificationMeta('isPremium');
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
      'is_premium', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_premium" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        themeMode,
        currency,
        defaultProfitMargin,
        pdfTemplate,
        companyName,
        companyAddress,
        companyPhone,
        companyEmail,
        logoPath,
        pdfFooterNote,
        isPremium
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('default_profit_margin')) {
      context.handle(
          _defaultProfitMarginMeta,
          defaultProfitMargin.isAcceptableOrUnknown(
              data['default_profit_margin']!, _defaultProfitMarginMeta));
    }
    if (data.containsKey('pdf_template')) {
      context.handle(
          _pdfTemplateMeta,
          pdfTemplate.isAcceptableOrUnknown(
              data['pdf_template']!, _pdfTemplateMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    if (data.containsKey('company_address')) {
      context.handle(
          _companyAddressMeta,
          companyAddress.isAcceptableOrUnknown(
              data['company_address']!, _companyAddressMeta));
    }
    if (data.containsKey('company_phone')) {
      context.handle(
          _companyPhoneMeta,
          companyPhone.isAcceptableOrUnknown(
              data['company_phone']!, _companyPhoneMeta));
    }
    if (data.containsKey('company_email')) {
      context.handle(
          _companyEmailMeta,
          companyEmail.isAcceptableOrUnknown(
              data['company_email']!, _companyEmailMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('pdf_footer_note')) {
      context.handle(
          _pdfFooterNoteMeta,
          pdfFooterNote.isAcceptableOrUnknown(
              data['pdf_footer_note']!, _pdfFooterNoteMeta));
    }
    if (data.containsKey('is_premium')) {
      context.handle(_isPremiumMeta,
          isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      defaultProfitMargin: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}default_profit_margin'])!,
      pdfTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pdf_template'])!,
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name']),
      companyAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_address']),
      companyPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_phone']),
      companyEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_email']),
      logoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      pdfFooterNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pdf_footer_note']),
      isPremium: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_premium'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String themeMode;
  final String currency;
  final double defaultProfitMargin;
  final String pdfTemplate;
  final String? companyName;
  final String? companyAddress;
  final String? companyPhone;
  final String? companyEmail;
  final String? logoPath;
  final String? pdfFooterNote;
  final bool isPremium;
  const AppSetting(
      {required this.id,
      required this.themeMode,
      required this.currency,
      required this.defaultProfitMargin,
      required this.pdfTemplate,
      this.companyName,
      this.companyAddress,
      this.companyPhone,
      this.companyEmail,
      this.logoPath,
      this.pdfFooterNote,
      required this.isPremium});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode'] = Variable<String>(themeMode);
    map['currency'] = Variable<String>(currency);
    map['default_profit_margin'] = Variable<double>(defaultProfitMargin);
    map['pdf_template'] = Variable<String>(pdfTemplate);
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || companyAddress != null) {
      map['company_address'] = Variable<String>(companyAddress);
    }
    if (!nullToAbsent || companyPhone != null) {
      map['company_phone'] = Variable<String>(companyPhone);
    }
    if (!nullToAbsent || companyEmail != null) {
      map['company_email'] = Variable<String>(companyEmail);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || pdfFooterNote != null) {
      map['pdf_footer_note'] = Variable<String>(pdfFooterNote);
    }
    map['is_premium'] = Variable<bool>(isPremium);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      currency: Value(currency),
      defaultProfitMargin: Value(defaultProfitMargin),
      pdfTemplate: Value(pdfTemplate),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      companyAddress: companyAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(companyAddress),
      companyPhone: companyPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(companyPhone),
      companyEmail: companyEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(companyEmail),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      pdfFooterNote: pdfFooterNote == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfFooterNote),
      isPremium: Value(isPremium),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      currency: serializer.fromJson<String>(json['currency']),
      defaultProfitMargin:
          serializer.fromJson<double>(json['defaultProfitMargin']),
      pdfTemplate: serializer.fromJson<String>(json['pdfTemplate']),
      companyName: serializer.fromJson<String?>(json['companyName']),
      companyAddress: serializer.fromJson<String?>(json['companyAddress']),
      companyPhone: serializer.fromJson<String?>(json['companyPhone']),
      companyEmail: serializer.fromJson<String?>(json['companyEmail']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      pdfFooterNote: serializer.fromJson<String?>(json['pdfFooterNote']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(themeMode),
      'currency': serializer.toJson<String>(currency),
      'defaultProfitMargin': serializer.toJson<double>(defaultProfitMargin),
      'pdfTemplate': serializer.toJson<String>(pdfTemplate),
      'companyName': serializer.toJson<String?>(companyName),
      'companyAddress': serializer.toJson<String?>(companyAddress),
      'companyPhone': serializer.toJson<String?>(companyPhone),
      'companyEmail': serializer.toJson<String?>(companyEmail),
      'logoPath': serializer.toJson<String?>(logoPath),
      'pdfFooterNote': serializer.toJson<String?>(pdfFooterNote),
      'isPremium': serializer.toJson<bool>(isPremium),
    };
  }

  AppSetting copyWith(
          {int? id,
          String? themeMode,
          String? currency,
          double? defaultProfitMargin,
          String? pdfTemplate,
          Value<String?> companyName = const Value.absent(),
          Value<String?> companyAddress = const Value.absent(),
          Value<String?> companyPhone = const Value.absent(),
          Value<String?> companyEmail = const Value.absent(),
          Value<String?> logoPath = const Value.absent(),
          Value<String?> pdfFooterNote = const Value.absent(),
          bool? isPremium}) =>
      AppSetting(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        currency: currency ?? this.currency,
        defaultProfitMargin: defaultProfitMargin ?? this.defaultProfitMargin,
        pdfTemplate: pdfTemplate ?? this.pdfTemplate,
        companyName: companyName.present ? companyName.value : this.companyName,
        companyAddress:
            companyAddress.present ? companyAddress.value : this.companyAddress,
        companyPhone:
            companyPhone.present ? companyPhone.value : this.companyPhone,
        companyEmail:
            companyEmail.present ? companyEmail.value : this.companyEmail,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        pdfFooterNote:
            pdfFooterNote.present ? pdfFooterNote.value : this.pdfFooterNote,
        isPremium: isPremium ?? this.isPremium,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      currency: data.currency.present ? data.currency.value : this.currency,
      defaultProfitMargin: data.defaultProfitMargin.present
          ? data.defaultProfitMargin.value
          : this.defaultProfitMargin,
      pdfTemplate:
          data.pdfTemplate.present ? data.pdfTemplate.value : this.pdfTemplate,
      companyName:
          data.companyName.present ? data.companyName.value : this.companyName,
      companyAddress: data.companyAddress.present
          ? data.companyAddress.value
          : this.companyAddress,
      companyPhone: data.companyPhone.present
          ? data.companyPhone.value
          : this.companyPhone,
      companyEmail: data.companyEmail.present
          ? data.companyEmail.value
          : this.companyEmail,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      pdfFooterNote: data.pdfFooterNote.present
          ? data.pdfFooterNote.value
          : this.pdfFooterNote,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('currency: $currency, ')
          ..write('defaultProfitMargin: $defaultProfitMargin, ')
          ..write('pdfTemplate: $pdfTemplate, ')
          ..write('companyName: $companyName, ')
          ..write('companyAddress: $companyAddress, ')
          ..write('companyPhone: $companyPhone, ')
          ..write('companyEmail: $companyEmail, ')
          ..write('logoPath: $logoPath, ')
          ..write('pdfFooterNote: $pdfFooterNote, ')
          ..write('isPremium: $isPremium')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      themeMode,
      currency,
      defaultProfitMargin,
      pdfTemplate,
      companyName,
      companyAddress,
      companyPhone,
      companyEmail,
      logoPath,
      pdfFooterNote,
      isPremium);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.currency == this.currency &&
          other.defaultProfitMargin == this.defaultProfitMargin &&
          other.pdfTemplate == this.pdfTemplate &&
          other.companyName == this.companyName &&
          other.companyAddress == this.companyAddress &&
          other.companyPhone == this.companyPhone &&
          other.companyEmail == this.companyEmail &&
          other.logoPath == this.logoPath &&
          other.pdfFooterNote == this.pdfFooterNote &&
          other.isPremium == this.isPremium);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> themeMode;
  final Value<String> currency;
  final Value<double> defaultProfitMargin;
  final Value<String> pdfTemplate;
  final Value<String?> companyName;
  final Value<String?> companyAddress;
  final Value<String?> companyPhone;
  final Value<String?> companyEmail;
  final Value<String?> logoPath;
  final Value<String?> pdfFooterNote;
  final Value<bool> isPremium;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.currency = const Value.absent(),
    this.defaultProfitMargin = const Value.absent(),
    this.pdfTemplate = const Value.absent(),
    this.companyName = const Value.absent(),
    this.companyAddress = const Value.absent(),
    this.companyPhone = const Value.absent(),
    this.companyEmail = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.pdfFooterNote = const Value.absent(),
    this.isPremium = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.currency = const Value.absent(),
    this.defaultProfitMargin = const Value.absent(),
    this.pdfTemplate = const Value.absent(),
    this.companyName = const Value.absent(),
    this.companyAddress = const Value.absent(),
    this.companyPhone = const Value.absent(),
    this.companyEmail = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.pdfFooterNote = const Value.absent(),
    this.isPremium = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<String>? currency,
    Expression<double>? defaultProfitMargin,
    Expression<String>? pdfTemplate,
    Expression<String>? companyName,
    Expression<String>? companyAddress,
    Expression<String>? companyPhone,
    Expression<String>? companyEmail,
    Expression<String>? logoPath,
    Expression<String>? pdfFooterNote,
    Expression<bool>? isPremium,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (currency != null) 'currency': currency,
      if (defaultProfitMargin != null)
        'default_profit_margin': defaultProfitMargin,
      if (pdfTemplate != null) 'pdf_template': pdfTemplate,
      if (companyName != null) 'company_name': companyName,
      if (companyAddress != null) 'company_address': companyAddress,
      if (companyPhone != null) 'company_phone': companyPhone,
      if (companyEmail != null) 'company_email': companyEmail,
      if (logoPath != null) 'logo_path': logoPath,
      if (pdfFooterNote != null) 'pdf_footer_note': pdfFooterNote,
      if (isPremium != null) 'is_premium': isPremium,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? themeMode,
      Value<String>? currency,
      Value<double>? defaultProfitMargin,
      Value<String>? pdfTemplate,
      Value<String?>? companyName,
      Value<String?>? companyAddress,
      Value<String?>? companyPhone,
      Value<String?>? companyEmail,
      Value<String?>? logoPath,
      Value<String?>? pdfFooterNote,
      Value<bool>? isPremium}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      defaultProfitMargin: defaultProfitMargin ?? this.defaultProfitMargin,
      pdfTemplate: pdfTemplate ?? this.pdfTemplate,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
      logoPath: logoPath ?? this.logoPath,
      pdfFooterNote: pdfFooterNote ?? this.pdfFooterNote,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (defaultProfitMargin.present) {
      map['default_profit_margin'] =
          Variable<double>(defaultProfitMargin.value);
    }
    if (pdfTemplate.present) {
      map['pdf_template'] = Variable<String>(pdfTemplate.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (companyAddress.present) {
      map['company_address'] = Variable<String>(companyAddress.value);
    }
    if (companyPhone.present) {
      map['company_phone'] = Variable<String>(companyPhone.value);
    }
    if (companyEmail.present) {
      map['company_email'] = Variable<String>(companyEmail.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (pdfFooterNote.present) {
      map['pdf_footer_note'] = Variable<String>(pdfFooterNote.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('currency: $currency, ')
          ..write('defaultProfitMargin: $defaultProfitMargin, ')
          ..write('pdfTemplate: $pdfTemplate, ')
          ..write('companyName: $companyName, ')
          ..write('companyAddress: $companyAddress, ')
          ..write('companyPhone: $companyPhone, ')
          ..write('companyEmail: $companyEmail, ')
          ..write('logoPath: $logoPath, ')
          ..write('pdfFooterNote: $pdfFooterNote, ')
          ..write('isPremium: $isPremium')
          ..write(')'))
        .toString();
  }
}

class $MaterialTemplatesTable extends MaterialTemplates
    with TableInfo<$MaterialTemplatesTable, MaterialTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaterialTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('adet'));
  static const VerificationMeta _defaultCostMeta =
      const VerificationMeta('defaultCost');
  @override
  late final GeneratedColumn<double> defaultCost = GeneratedColumn<double>(
      'default_cost', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _defaultSaleMeta =
      const VerificationMeta('defaultSale');
  @override
  late final GeneratedColumn<double> defaultSale = GeneratedColumn<double>(
      'default_sale', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, unit, defaultCost, defaultSale, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'material_templates';
  @override
  VerificationContext validateIntegrity(Insertable<MaterialTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('default_cost')) {
      context.handle(
          _defaultCostMeta,
          defaultCost.isAcceptableOrUnknown(
              data['default_cost']!, _defaultCostMeta));
    }
    if (data.containsKey('default_sale')) {
      context.handle(
          _defaultSaleMeta,
          defaultSale.isAcceptableOrUnknown(
              data['default_sale']!, _defaultSaleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaterialTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      defaultCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}default_cost'])!,
      defaultSale: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}default_sale'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MaterialTemplatesTable createAlias(String alias) {
    return $MaterialTemplatesTable(attachedDatabase, alias);
  }
}

class MaterialTemplate extends DataClass
    implements Insertable<MaterialTemplate> {
  final int id;
  final String name;
  final String? category;
  final String unit;
  final double defaultCost;
  final double defaultSale;
  final DateTime createdAt;
  const MaterialTemplate(
      {required this.id,
      required this.name,
      this.category,
      required this.unit,
      required this.defaultCost,
      required this.defaultSale,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['unit'] = Variable<String>(unit);
    map['default_cost'] = Variable<double>(defaultCost);
    map['default_sale'] = Variable<double>(defaultSale);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaterialTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MaterialTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      unit: Value(unit),
      defaultCost: Value(defaultCost),
      defaultSale: Value(defaultSale),
      createdAt: Value(createdAt),
    );
  }

  factory MaterialTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaterialTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      defaultCost: serializer.fromJson<double>(json['defaultCost']),
      defaultSale: serializer.fromJson<double>(json['defaultSale']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'unit': serializer.toJson<String>(unit),
      'defaultCost': serializer.toJson<double>(defaultCost),
      'defaultSale': serializer.toJson<double>(defaultSale),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaterialTemplate copyWith(
          {int? id,
          String? name,
          Value<String?> category = const Value.absent(),
          String? unit,
          double? defaultCost,
          double? defaultSale,
          DateTime? createdAt}) =>
      MaterialTemplate(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category.present ? category.value : this.category,
        unit: unit ?? this.unit,
        defaultCost: defaultCost ?? this.defaultCost,
        defaultSale: defaultSale ?? this.defaultSale,
        createdAt: createdAt ?? this.createdAt,
      );
  MaterialTemplate copyWithCompanion(MaterialTemplatesCompanion data) {
    return MaterialTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      defaultCost:
          data.defaultCost.present ? data.defaultCost.value : this.defaultCost,
      defaultSale:
          data.defaultSale.present ? data.defaultSale.value : this.defaultSale,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaterialTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('defaultCost: $defaultCost, ')
          ..write('defaultSale: $defaultSale, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, category, unit, defaultCost, defaultSale, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaterialTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.defaultCost == this.defaultCost &&
          other.defaultSale == this.defaultSale &&
          other.createdAt == this.createdAt);
}

class MaterialTemplatesCompanion extends UpdateCompanion<MaterialTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<String> unit;
  final Value<double> defaultCost;
  final Value<double> defaultSale;
  final Value<DateTime> createdAt;
  const MaterialTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.defaultCost = const Value.absent(),
    this.defaultSale = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MaterialTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.defaultCost = const Value.absent(),
    this.defaultSale = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<MaterialTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<double>? defaultCost,
    Expression<double>? defaultSale,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (defaultCost != null) 'default_cost': defaultCost,
      if (defaultSale != null) 'default_sale': defaultSale,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MaterialTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? category,
      Value<String>? unit,
      Value<double>? defaultCost,
      Value<double>? defaultSale,
      Value<DateTime>? createdAt}) {
    return MaterialTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      defaultCost: defaultCost ?? this.defaultCost,
      defaultSale: defaultSale ?? this.defaultSale,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (defaultCost.present) {
      map['default_cost'] = Variable<double>(defaultCost.value);
    }
    if (defaultSale.present) {
      map['default_sale'] = Variable<double>(defaultSale.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('defaultCost: $defaultCost, ')
          ..write('defaultSale: $defaultSale, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BudgetPeriodsTable extends BudgetPeriods
    with TableInfo<$BudgetPeriodsTable, BudgetPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _openingBalanceMeta =
      const VerificationMeta('openingBalance');
  @override
  late final GeneratedColumn<double> openingBalance = GeneratedColumn<double>(
      'opening_balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _closingBalanceMeta =
      const VerificationMeta('closingBalance');
  @override
  late final GeneratedColumn<double> closingBalance = GeneratedColumn<double>(
      'closing_balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        startDate,
        endDate,
        isActive,
        openingBalance,
        closingBalance,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_periods';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetPeriod> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
          _openingBalanceMeta,
          openingBalance.isAcceptableOrUnknown(
              data['opening_balance']!, _openingBalanceMeta));
    }
    if (data.containsKey('closing_balance')) {
      context.handle(
          _closingBalanceMeta,
          closingBalance.isAcceptableOrUnknown(
              data['closing_balance']!, _closingBalanceMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetPeriod(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      openingBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}opening_balance'])!,
      closingBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}closing_balance'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BudgetPeriodsTable createAlias(String alias) {
    return $BudgetPeriodsTable(attachedDatabase, alias);
  }
}

class BudgetPeriod extends DataClass implements Insertable<BudgetPeriod> {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final double openingBalance;
  final double closingBalance;
  final DateTime createdAt;
  const BudgetPeriod(
      {required this.id,
      required this.name,
      required this.startDate,
      this.endDate,
      required this.isActive,
      required this.openingBalance,
      required this.closingBalance,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['opening_balance'] = Variable<double>(openingBalance);
    map['closing_balance'] = Variable<double>(closingBalance);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BudgetPeriodsCompanion toCompanion(bool nullToAbsent) {
    return BudgetPeriodsCompanion(
      id: Value(id),
      name: Value(name),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isActive: Value(isActive),
      openingBalance: Value(openingBalance),
      closingBalance: Value(closingBalance),
      createdAt: Value(createdAt),
    );
  }

  factory BudgetPeriod.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetPeriod(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      openingBalance: serializer.fromJson<double>(json['openingBalance']),
      closingBalance: serializer.fromJson<double>(json['closingBalance']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'isActive': serializer.toJson<bool>(isActive),
      'openingBalance': serializer.toJson<double>(openingBalance),
      'closingBalance': serializer.toJson<double>(closingBalance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BudgetPeriod copyWith(
          {int? id,
          String? name,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          bool? isActive,
          double? openingBalance,
          double? closingBalance,
          DateTime? createdAt}) =>
      BudgetPeriod(
        id: id ?? this.id,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        isActive: isActive ?? this.isActive,
        openingBalance: openingBalance ?? this.openingBalance,
        closingBalance: closingBalance ?? this.closingBalance,
        createdAt: createdAt ?? this.createdAt,
      );
  BudgetPeriod copyWithCompanion(BudgetPeriodsCompanion data) {
    return BudgetPeriod(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      closingBalance: data.closingBalance.present
          ? data.closingBalance.value
          : this.closingBalance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPeriod(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('closingBalance: $closingBalance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, startDate, endDate, isActive,
      openingBalance, closingBalance, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetPeriod &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isActive == this.isActive &&
          other.openingBalance == this.openingBalance &&
          other.closingBalance == this.closingBalance &&
          other.createdAt == this.createdAt);
}

class BudgetPeriodsCompanion extends UpdateCompanion<BudgetPeriod> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<bool> isActive;
  final Value<double> openingBalance;
  final Value<double> closingBalance;
  final Value<DateTime> createdAt;
  const BudgetPeriodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.closingBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BudgetPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.closingBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        startDate = Value(startDate);
  static Insertable<BudgetPeriod> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isActive,
    Expression<double>? openingBalance,
    Expression<double>? closingBalance,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isActive != null) 'is_active': isActive,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (closingBalance != null) 'closing_balance': closingBalance,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BudgetPeriodsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<bool>? isActive,
      Value<double>? openingBalance,
      Value<double>? closingBalance,
      Value<DateTime>? createdAt}) {
    return BudgetPeriodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      openingBalance: openingBalance ?? this.openingBalance,
      closingBalance: closingBalance ?? this.closingBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<double>(openingBalance.value);
    }
    if (closingBalance.present) {
      map['closing_balance'] = Variable<double>(closingBalance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('closingBalance: $closingBalance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
      'job_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES jobs (id)'));
  static const VerificationMeta _periodIdMeta =
      const VerificationMeta('periodId');
  @override
  late final GeneratedColumn<int> periodId = GeneratedColumn<int>(
      'period_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES budget_periods (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('partial'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        jobId,
        periodId,
        type,
        amount,
        paymentDate,
        method,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('period_id')) {
      context.handle(_periodIdMeta,
          periodId.isAcceptableOrUnknown(data['period_id']!, _periodIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}job_id'])!,
      periodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}period_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int jobId;
  final int? periodId;
  final String type;
  final double amount;
  final DateTime paymentDate;
  final String method;
  final String? notes;
  final DateTime createdAt;
  const Payment(
      {required this.id,
      required this.jobId,
      this.periodId,
      required this.type,
      required this.amount,
      required this.paymentDate,
      required this.method,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    if (!nullToAbsent || periodId != null) {
      map['period_id'] = Variable<int>(periodId);
    }
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      periodId: periodId == null && nullToAbsent
          ? const Value.absent()
          : Value(periodId),
      type: Value(type),
      amount: Value(amount),
      paymentDate: Value(paymentDate),
      method: Value(method),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      periodId: serializer.fromJson<int?>(json['periodId']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      method: serializer.fromJson<String>(json['method']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'periodId': serializer.toJson<int?>(periodId),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'method': serializer.toJson<String>(method),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Payment copyWith(
          {int? id,
          int? jobId,
          Value<int?> periodId = const Value.absent(),
          String? type,
          double? amount,
          DateTime? paymentDate,
          String? method,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Payment(
        id: id ?? this.id,
        jobId: jobId ?? this.jobId,
        periodId: periodId.present ? periodId.value : this.periodId,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        paymentDate: paymentDate ?? this.paymentDate,
        method: method ?? this.method,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      periodId: data.periodId.present ? data.periodId.value : this.periodId,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      method: data.method.present ? data.method.value : this.method,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('periodId: $periodId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('method: $method, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, jobId, periodId, type, amount, paymentDate, method, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.periodId == this.periodId &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.paymentDate == this.paymentDate &&
          other.method == this.method &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<int?> periodId;
  final Value<String> type;
  final Value<double> amount;
  final Value<DateTime> paymentDate;
  final Value<String> method;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.periodId = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.method = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    this.periodId = const Value.absent(),
    this.type = const Value.absent(),
    required double amount,
    this.paymentDate = const Value.absent(),
    this.method = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : jobId = Value(jobId),
        amount = Value(amount);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<int>? periodId,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<DateTime>? paymentDate,
    Expression<String>? method,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (periodId != null) 'period_id': periodId,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (method != null) 'method': method,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? jobId,
      Value<int?>? periodId,
      Value<String>? type,
      Value<double>? amount,
      Value<DateTime>? paymentDate,
      Value<String>? method,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      periodId: periodId ?? this.periodId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      method: method ?? this.method,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (periodId.present) {
      map['period_id'] = Variable<int>(periodId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('periodId: $periodId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('method: $method, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _periodIdMeta =
      const VerificationMeta('periodId');
  @override
  late final GeneratedColumn<int> periodId = GeneratedColumn<int>(
      'period_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES budget_periods (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('expense'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, periodId, title, type, amount, date, category, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('period_id')) {
      context.handle(_periodIdMeta,
          periodId.isAcceptableOrUnknown(data['period_id']!, _periodIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      periodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}period_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int? periodId;
  final String title;
  final String type;
  final double amount;
  final DateTime date;
  final String? category;
  final String? notes;
  final DateTime createdAt;
  const Transaction(
      {required this.id,
      this.periodId,
      required this.title,
      required this.type,
      required this.amount,
      required this.date,
      this.category,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || periodId != null) {
      map['period_id'] = Variable<int>(periodId);
    }
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      periodId: periodId == null && nullToAbsent
          ? const Value.absent()
          : Value(periodId),
      title: Value(title),
      type: Value(type),
      amount: Value(amount),
      date: Value(date),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      periodId: serializer.fromJson<int?>(json['periodId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: serializer.fromJson<String?>(json['category']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'periodId': serializer.toJson<int?>(periodId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String?>(category),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith(
          {int? id,
          Value<int?> periodId = const Value.absent(),
          String? title,
          String? type,
          double? amount,
          DateTime? date,
          Value<String?> category = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Transaction(
        id: id ?? this.id,
        periodId: periodId.present ? periodId.value : this.periodId,
        title: title ?? this.title,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        category: category.present ? category.value : this.category,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      periodId: data.periodId.present ? data.periodId.value : this.periodId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('periodId: $periodId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, periodId, title, type, amount, date, category, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.periodId == this.periodId &&
          other.title == this.title &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.category == this.category &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int?> periodId;
  final Value<String> title;
  final Value<String> type;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> category;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.periodId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.periodId = const Value.absent(),
    required String title,
    this.type = const Value.absent(),
    required double amount,
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        amount = Value(amount);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? periodId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (periodId != null) 'period_id': periodId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? periodId,
      Value<String>? title,
      Value<String>? type,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String?>? category,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      periodId: periodId ?? this.periodId,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (periodId.present) {
      map['period_id'] = Variable<int>(periodId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('periodId: $periodId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $LineItemsTable lineItems = $LineItemsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $JobImagesTable jobImages = $JobImagesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $MaterialTemplatesTable materialTemplates =
      $MaterialTemplatesTable(this);
  late final $BudgetPeriodsTable budgetPeriods = $BudgetPeriodsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final JobDao jobDao = JobDao(this as AppDatabase);
  late final LineItemDao lineItemDao = LineItemDao(this as AppDatabase);
  late final ReminderDao reminderDao = ReminderDao(this as AppDatabase);
  late final JobImageDao jobImageDao = JobImageDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final MaterialTemplateDao materialTemplateDao =
      MaterialTemplateDao(this as AppDatabase);
  late final PaymentDao paymentDao = PaymentDao(this as AppDatabase);
  late final TransactionDao transactionDao =
      TransactionDao(this as AppDatabase);
  late final PeriodDao periodDao = PeriodDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        customers,
        jobs,
        lineItems,
        reminders,
        jobImages,
        appSettings,
        materialTemplates,
        budgetPeriods,
        payments,
        transactions
      ];
}

typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> type,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  Value<String> tags,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isDeleted,
  Value<DateTime?> deletedAt,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> type,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  Value<String> tags,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isDeleted,
  Value<DateTime?> deletedAt,
});

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CustomersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CustomersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            type: type,
            name: name,
            phone: phone,
            email: email,
            address: address,
            notes: notes,
            tags: tags,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            type: type,
            name: name,
            phone: phone,
            email: email,
            address: address,
            notes: notes,
            tags: tags,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
          ),
        ));
}

class $$CustomersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tags => $state.composableBuilder(
      column: $state.table.tags,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDeleted => $state.composableBuilder(
      column: $state.table.isDeleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter jobsRefs(
      ComposableFilter Function($$JobsTableFilterComposer f) f) {
    final $$JobsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder, parentComposers) => $$JobsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tags => $state.composableBuilder(
      column: $state.table.tags,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDeleted => $state.composableBuilder(
      column: $state.table.isDeleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$JobsTableCreateCompanionBuilder = JobsCompanion Function({
  Value<int> id,
  required int customerId,
  required String title,
  Value<String?> description,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime?> dueDate,
  Value<String?> location,
  Value<String?> notes,
  Value<double> totalCost,
  Value<double> totalSale,
  Value<double> profit,
  Value<double> profitRate,
  Value<double> quotedPrice,
  Value<double> depositAmount,
  Value<double> collectedAmount,
  Value<double> customExpense,
  Value<bool> pdfSent,
  Value<DateTime?> pdfSentAt,
  Value<bool> isDeleted,
  Value<DateTime?> deletedAt,
});
typedef $$JobsTableUpdateCompanionBuilder = JobsCompanion Function({
  Value<int> id,
  Value<int> customerId,
  Value<String> title,
  Value<String?> description,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime?> dueDate,
  Value<String?> location,
  Value<String?> notes,
  Value<double> totalCost,
  Value<double> totalSale,
  Value<double> profit,
  Value<double> profitRate,
  Value<double> quotedPrice,
  Value<double> depositAmount,
  Value<double> collectedAmount,
  Value<double> customExpense,
  Value<bool> pdfSent,
  Value<DateTime?> pdfSentAt,
  Value<bool> isDeleted,
  Value<DateTime?> deletedAt,
});

class $$JobsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JobsTable,
    Job,
    $$JobsTableFilterComposer,
    $$JobsTableOrderingComposer,
    $$JobsTableCreateCompanionBuilder,
    $$JobsTableUpdateCompanionBuilder> {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$JobsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$JobsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double> totalCost = const Value.absent(),
            Value<double> totalSale = const Value.absent(),
            Value<double> profit = const Value.absent(),
            Value<double> profitRate = const Value.absent(),
            Value<double> quotedPrice = const Value.absent(),
            Value<double> depositAmount = const Value.absent(),
            Value<double> collectedAmount = const Value.absent(),
            Value<double> customExpense = const Value.absent(),
            Value<bool> pdfSent = const Value.absent(),
            Value<DateTime?> pdfSentAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              JobsCompanion(
            id: id,
            customerId: customerId,
            title: title,
            description: description,
            status: status,
            createdAt: createdAt,
            dueDate: dueDate,
            location: location,
            notes: notes,
            totalCost: totalCost,
            totalSale: totalSale,
            profit: profit,
            profitRate: profitRate,
            quotedPrice: quotedPrice,
            depositAmount: depositAmount,
            collectedAmount: collectedAmount,
            customExpense: customExpense,
            pdfSent: pdfSent,
            pdfSentAt: pdfSentAt,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int customerId,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double> totalCost = const Value.absent(),
            Value<double> totalSale = const Value.absent(),
            Value<double> profit = const Value.absent(),
            Value<double> profitRate = const Value.absent(),
            Value<double> quotedPrice = const Value.absent(),
            Value<double> depositAmount = const Value.absent(),
            Value<double> collectedAmount = const Value.absent(),
            Value<double> customExpense = const Value.absent(),
            Value<bool> pdfSent = const Value.absent(),
            Value<DateTime?> pdfSentAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              JobsCompanion.insert(
            id: id,
            customerId: customerId,
            title: title,
            description: description,
            status: status,
            createdAt: createdAt,
            dueDate: dueDate,
            location: location,
            notes: notes,
            totalCost: totalCost,
            totalSale: totalSale,
            profit: profit,
            profitRate: profitRate,
            quotedPrice: quotedPrice,
            depositAmount: depositAmount,
            collectedAmount: collectedAmount,
            customExpense: customExpense,
            pdfSent: pdfSent,
            pdfSentAt: pdfSentAt,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
          ),
        ));
}

class $$JobsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dueDate => $state.composableBuilder(
      column: $state.table.dueDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalCost => $state.composableBuilder(
      column: $state.table.totalCost,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalSale => $state.composableBuilder(
      column: $state.table.totalSale,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get profit => $state.composableBuilder(
      column: $state.table.profit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get profitRate => $state.composableBuilder(
      column: $state.table.profitRate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get quotedPrice => $state.composableBuilder(
      column: $state.table.quotedPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get depositAmount => $state.composableBuilder(
      column: $state.table.depositAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get collectedAmount => $state.composableBuilder(
      column: $state.table.collectedAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get customExpense => $state.composableBuilder(
      column: $state.table.customExpense,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get pdfSent => $state.composableBuilder(
      column: $state.table.pdfSent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get pdfSentAt => $state.composableBuilder(
      column: $state.table.pdfSentAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDeleted => $state.composableBuilder(
      column: $state.table.isDeleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter lineItemsRefs(
      ComposableFilter Function($$LineItemsTableFilterComposer f) f) {
    final $$LineItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.lineItems,
        getReferencedColumn: (t) => t.jobId,
        builder: (joinBuilder, parentComposers) =>
            $$LineItemsTableFilterComposer(ComposerState(
                $state.db, $state.db.lineItems, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter remindersRefs(
      ComposableFilter Function($$RemindersTableFilterComposer f) f) {
    final $$RemindersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.reminders,
        getReferencedColumn: (t) => t.jobId,
        builder: (joinBuilder, parentComposers) =>
            $$RemindersTableFilterComposer(ComposerState(
                $state.db, $state.db.reminders, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter jobImagesRefs(
      ComposableFilter Function($$JobImagesTableFilterComposer f) f) {
    final $$JobImagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.jobImages,
        getReferencedColumn: (t) => t.jobId,
        builder: (joinBuilder, parentComposers) =>
            $$JobImagesTableFilterComposer(ComposerState(
                $state.db, $state.db.jobImages, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter paymentsRefs(
      ComposableFilter Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.payments,
        getReferencedColumn: (t) => t.jobId,
        builder: (joinBuilder, parentComposers) =>
            $$PaymentsTableFilterComposer(ComposerState(
                $state.db, $state.db.payments, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$JobsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dueDate => $state.composableBuilder(
      column: $state.table.dueDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalCost => $state.composableBuilder(
      column: $state.table.totalCost,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalSale => $state.composableBuilder(
      column: $state.table.totalSale,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get profit => $state.composableBuilder(
      column: $state.table.profit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get profitRate => $state.composableBuilder(
      column: $state.table.profitRate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get quotedPrice => $state.composableBuilder(
      column: $state.table.quotedPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get depositAmount => $state.composableBuilder(
      column: $state.table.depositAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get collectedAmount => $state.composableBuilder(
      column: $state.table.collectedAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get customExpense => $state.composableBuilder(
      column: $state.table.customExpense,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get pdfSent => $state.composableBuilder(
      column: $state.table.pdfSent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get pdfSentAt => $state.composableBuilder(
      column: $state.table.pdfSentAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDeleted => $state.composableBuilder(
      column: $state.table.isDeleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$LineItemsTableCreateCompanionBuilder = LineItemsCompanion Function({
  Value<int> id,
  required int jobId,
  Value<String> type,
  required String name,
  Value<String?> description,
  Value<double> quantity,
  Value<String> unit,
  Value<double> costPerUnit,
  Value<double> salePerUnit,
  Value<String> taxMode,
  Value<String?> supplierNote,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
});
typedef $$LineItemsTableUpdateCompanionBuilder = LineItemsCompanion Function({
  Value<int> id,
  Value<int> jobId,
  Value<String> type,
  Value<String> name,
  Value<String?> description,
  Value<double> quantity,
  Value<String> unit,
  Value<double> costPerUnit,
  Value<double> salePerUnit,
  Value<String> taxMode,
  Value<String?> supplierNote,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
});

class $$LineItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LineItemsTable,
    LineItem,
    $$LineItemsTableFilterComposer,
    $$LineItemsTableOrderingComposer,
    $$LineItemsTableCreateCompanionBuilder,
    $$LineItemsTableUpdateCompanionBuilder> {
  $$LineItemsTableTableManager(_$AppDatabase db, $LineItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LineItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LineItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> jobId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<double> costPerUnit = const Value.absent(),
            Value<double> salePerUnit = const Value.absent(),
            Value<String> taxMode = const Value.absent(),
            Value<String?> supplierNote = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LineItemsCompanion(
            id: id,
            jobId: jobId,
            type: type,
            name: name,
            description: description,
            quantity: quantity,
            unit: unit,
            costPerUnit: costPerUnit,
            salePerUnit: salePerUnit,
            taxMode: taxMode,
            supplierNote: supplierNote,
            sortOrder: sortOrder,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int jobId,
            Value<String> type = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<double> costPerUnit = const Value.absent(),
            Value<double> salePerUnit = const Value.absent(),
            Value<String> taxMode = const Value.absent(),
            Value<String?> supplierNote = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LineItemsCompanion.insert(
            id: id,
            jobId: jobId,
            type: type,
            name: name,
            description: description,
            quantity: quantity,
            unit: unit,
            costPerUnit: costPerUnit,
            salePerUnit: salePerUnit,
            taxMode: taxMode,
            supplierNote: supplierNote,
            sortOrder: sortOrder,
            createdAt: createdAt,
          ),
        ));
}

class $$LineItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LineItemsTable> {
  $$LineItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get unit => $state.composableBuilder(
      column: $state.table.unit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get costPerUnit => $state.composableBuilder(
      column: $state.table.costPerUnit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get salePerUnit => $state.composableBuilder(
      column: $state.table.salePerUnit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get taxMode => $state.composableBuilder(
      column: $state.table.taxMode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get supplierNote => $state.composableBuilder(
      column: $state.table.supplierNote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$LineItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LineItemsTable> {
  $$LineItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get unit => $state.composableBuilder(
      column: $state.table.unit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get costPerUnit => $state.composableBuilder(
      column: $state.table.costPerUnit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get salePerUnit => $state.composableBuilder(
      column: $state.table.salePerUnit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get taxMode => $state.composableBuilder(
      column: $state.table.taxMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get supplierNote => $state.composableBuilder(
      column: $state.table.supplierNote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  Value<int> id,
  required int jobId,
  required String title,
  Value<String?> description,
  required DateTime scheduledAt,
  Value<String?> repeatRule,
  required int notificationId,
  Value<bool> enabled,
  Value<bool> isCompleted,
  Value<String> priority,
  Value<String?> soundType,
  Value<DateTime> createdAt,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<int> id,
  Value<int> jobId,
  Value<String> title,
  Value<String?> description,
  Value<DateTime> scheduledAt,
  Value<String?> repeatRule,
  Value<int> notificationId,
  Value<bool> enabled,
  Value<bool> isCompleted,
  Value<String> priority,
  Value<String?> soundType,
  Value<DateTime> createdAt,
});

class $$RemindersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder> {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RemindersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RemindersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> jobId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> scheduledAt = const Value.absent(),
            Value<String?> repeatRule = const Value.absent(),
            Value<int> notificationId = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String?> soundType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RemindersCompanion(
            id: id,
            jobId: jobId,
            title: title,
            description: description,
            scheduledAt: scheduledAt,
            repeatRule: repeatRule,
            notificationId: notificationId,
            enabled: enabled,
            isCompleted: isCompleted,
            priority: priority,
            soundType: soundType,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int jobId,
            required String title,
            Value<String?> description = const Value.absent(),
            required DateTime scheduledAt,
            Value<String?> repeatRule = const Value.absent(),
            required int notificationId,
            Value<bool> enabled = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String?> soundType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RemindersCompanion.insert(
            id: id,
            jobId: jobId,
            title: title,
            description: description,
            scheduledAt: scheduledAt,
            repeatRule: repeatRule,
            notificationId: notificationId,
            enabled: enabled,
            isCompleted: isCompleted,
            priority: priority,
            soundType: soundType,
            createdAt: createdAt,
          ),
        ));
}

class $$RemindersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get scheduledAt => $state.composableBuilder(
      column: $state.table.scheduledAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get repeatRule => $state.composableBuilder(
      column: $state.table.repeatRule,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get notificationId => $state.composableBuilder(
      column: $state.table.notificationId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get enabled => $state.composableBuilder(
      column: $state.table.enabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get soundType => $state.composableBuilder(
      column: $state.table.soundType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get scheduledAt => $state.composableBuilder(
      column: $state.table.scheduledAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get repeatRule => $state.composableBuilder(
      column: $state.table.repeatRule,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get notificationId => $state.composableBuilder(
      column: $state.table.notificationId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get enabled => $state.composableBuilder(
      column: $state.table.enabled,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get soundType => $state.composableBuilder(
      column: $state.table.soundType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$JobImagesTableCreateCompanionBuilder = JobImagesCompanion Function({
  Value<int> id,
  required int jobId,
  required String path,
  Value<String?> caption,
  Value<int> sortIndex,
  Value<DateTime> createdAt,
});
typedef $$JobImagesTableUpdateCompanionBuilder = JobImagesCompanion Function({
  Value<int> id,
  Value<int> jobId,
  Value<String> path,
  Value<String?> caption,
  Value<int> sortIndex,
  Value<DateTime> createdAt,
});

class $$JobImagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $JobImagesTable,
    JobImage,
    $$JobImagesTableFilterComposer,
    $$JobImagesTableOrderingComposer,
    $$JobImagesTableCreateCompanionBuilder,
    $$JobImagesTableUpdateCompanionBuilder> {
  $$JobImagesTableTableManager(_$AppDatabase db, $JobImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$JobImagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$JobImagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> jobId = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String?> caption = const Value.absent(),
            Value<int> sortIndex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              JobImagesCompanion(
            id: id,
            jobId: jobId,
            path: path,
            caption: caption,
            sortIndex: sortIndex,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int jobId,
            required String path,
            Value<String?> caption = const Value.absent(),
            Value<int> sortIndex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              JobImagesCompanion.insert(
            id: id,
            jobId: jobId,
            path: path,
            caption: caption,
            sortIndex: sortIndex,
            createdAt: createdAt,
          ),
        ));
}

class $$JobImagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $JobImagesTable> {
  $$JobImagesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get caption => $state.composableBuilder(
      column: $state.table.caption,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sortIndex => $state.composableBuilder(
      column: $state.table.sortIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$JobImagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $JobImagesTable> {
  $$JobImagesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get caption => $state.composableBuilder(
      column: $state.table.caption,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sortIndex => $state.composableBuilder(
      column: $state.table.sortIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> themeMode,
  Value<String> currency,
  Value<double> defaultProfitMargin,
  Value<String> pdfTemplate,
  Value<String?> companyName,
  Value<String?> companyAddress,
  Value<String?> companyPhone,
  Value<String?> companyEmail,
  Value<String?> logoPath,
  Value<String?> pdfFooterNote,
  Value<bool> isPremium,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> themeMode,
  Value<String> currency,
  Value<double> defaultProfitMargin,
  Value<String> pdfTemplate,
  Value<String?> companyName,
  Value<String?> companyAddress,
  Value<String?> companyPhone,
  Value<String?> companyEmail,
  Value<String?> logoPath,
  Value<String?> pdfFooterNote,
  Value<bool> isPremium,
});

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AppSettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AppSettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> defaultProfitMargin = const Value.absent(),
            Value<String> pdfTemplate = const Value.absent(),
            Value<String?> companyName = const Value.absent(),
            Value<String?> companyAddress = const Value.absent(),
            Value<String?> companyPhone = const Value.absent(),
            Value<String?> companyEmail = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String?> pdfFooterNote = const Value.absent(),
            Value<bool> isPremium = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            themeMode: themeMode,
            currency: currency,
            defaultProfitMargin: defaultProfitMargin,
            pdfTemplate: pdfTemplate,
            companyName: companyName,
            companyAddress: companyAddress,
            companyPhone: companyPhone,
            companyEmail: companyEmail,
            logoPath: logoPath,
            pdfFooterNote: pdfFooterNote,
            isPremium: isPremium,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> defaultProfitMargin = const Value.absent(),
            Value<String> pdfTemplate = const Value.absent(),
            Value<String?> companyName = const Value.absent(),
            Value<String?> companyAddress = const Value.absent(),
            Value<String?> companyPhone = const Value.absent(),
            Value<String?> companyEmail = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String?> pdfFooterNote = const Value.absent(),
            Value<bool> isPremium = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            themeMode: themeMode,
            currency: currency,
            defaultProfitMargin: defaultProfitMargin,
            pdfTemplate: pdfTemplate,
            companyName: companyName,
            companyAddress: companyAddress,
            companyPhone: companyPhone,
            companyEmail: companyEmail,
            logoPath: logoPath,
            pdfFooterNote: pdfFooterNote,
            isPremium: isPremium,
          ),
        ));
}

class $$AppSettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get themeMode => $state.composableBuilder(
      column: $state.table.themeMode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get defaultProfitMargin => $state.composableBuilder(
      column: $state.table.defaultProfitMargin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pdfTemplate => $state.composableBuilder(
      column: $state.table.pdfTemplate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get companyName => $state.composableBuilder(
      column: $state.table.companyName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get companyAddress => $state.composableBuilder(
      column: $state.table.companyAddress,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get companyPhone => $state.composableBuilder(
      column: $state.table.companyPhone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get companyEmail => $state.composableBuilder(
      column: $state.table.companyEmail,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get logoPath => $state.composableBuilder(
      column: $state.table.logoPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pdfFooterNote => $state.composableBuilder(
      column: $state.table.pdfFooterNote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPremium => $state.composableBuilder(
      column: $state.table.isPremium,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppSettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get themeMode => $state.composableBuilder(
      column: $state.table.themeMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get defaultProfitMargin => $state.composableBuilder(
      column: $state.table.defaultProfitMargin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pdfTemplate => $state.composableBuilder(
      column: $state.table.pdfTemplate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get companyName => $state.composableBuilder(
      column: $state.table.companyName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get companyAddress => $state.composableBuilder(
      column: $state.table.companyAddress,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get companyPhone => $state.composableBuilder(
      column: $state.table.companyPhone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get companyEmail => $state.composableBuilder(
      column: $state.table.companyEmail,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get logoPath => $state.composableBuilder(
      column: $state.table.logoPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pdfFooterNote => $state.composableBuilder(
      column: $state.table.pdfFooterNote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPremium => $state.composableBuilder(
      column: $state.table.isPremium,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MaterialTemplatesTableCreateCompanionBuilder
    = MaterialTemplatesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> category,
  Value<String> unit,
  Value<double> defaultCost,
  Value<double> defaultSale,
  Value<DateTime> createdAt,
});
typedef $$MaterialTemplatesTableUpdateCompanionBuilder
    = MaterialTemplatesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> category,
  Value<String> unit,
  Value<double> defaultCost,
  Value<double> defaultSale,
  Value<DateTime> createdAt,
});

class $$MaterialTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MaterialTemplatesTable,
    MaterialTemplate,
    $$MaterialTemplatesTableFilterComposer,
    $$MaterialTemplatesTableOrderingComposer,
    $$MaterialTemplatesTableCreateCompanionBuilder,
    $$MaterialTemplatesTableUpdateCompanionBuilder> {
  $$MaterialTemplatesTableTableManager(
      _$AppDatabase db, $MaterialTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MaterialTemplatesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$MaterialTemplatesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<double> defaultCost = const Value.absent(),
            Value<double> defaultSale = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MaterialTemplatesCompanion(
            id: id,
            name: name,
            category: category,
            unit: unit,
            defaultCost: defaultCost,
            defaultSale: defaultSale,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> category = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<double> defaultCost = const Value.absent(),
            Value<double> defaultSale = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MaterialTemplatesCompanion.insert(
            id: id,
            name: name,
            category: category,
            unit: unit,
            defaultCost: defaultCost,
            defaultSale: defaultSale,
            createdAt: createdAt,
          ),
        ));
}

class $$MaterialTemplatesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MaterialTemplatesTable> {
  $$MaterialTemplatesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get unit => $state.composableBuilder(
      column: $state.table.unit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get defaultCost => $state.composableBuilder(
      column: $state.table.defaultCost,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get defaultSale => $state.composableBuilder(
      column: $state.table.defaultSale,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MaterialTemplatesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MaterialTemplatesTable> {
  $$MaterialTemplatesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get unit => $state.composableBuilder(
      column: $state.table.unit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get defaultCost => $state.composableBuilder(
      column: $state.table.defaultCost,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get defaultSale => $state.composableBuilder(
      column: $state.table.defaultSale,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BudgetPeriodsTableCreateCompanionBuilder = BudgetPeriodsCompanion
    Function({
  Value<int> id,
  required String name,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<bool> isActive,
  Value<double> openingBalance,
  Value<double> closingBalance,
  Value<DateTime> createdAt,
});
typedef $$BudgetPeriodsTableUpdateCompanionBuilder = BudgetPeriodsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<bool> isActive,
  Value<double> openingBalance,
  Value<double> closingBalance,
  Value<DateTime> createdAt,
});

class $$BudgetPeriodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetPeriodsTable,
    BudgetPeriod,
    $$BudgetPeriodsTableFilterComposer,
    $$BudgetPeriodsTableOrderingComposer,
    $$BudgetPeriodsTableCreateCompanionBuilder,
    $$BudgetPeriodsTableUpdateCompanionBuilder> {
  $$BudgetPeriodsTableTableManager(_$AppDatabase db, $BudgetPeriodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BudgetPeriodsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BudgetPeriodsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<double> openingBalance = const Value.absent(),
            Value<double> closingBalance = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BudgetPeriodsCompanion(
            id: id,
            name: name,
            startDate: startDate,
            endDate: endDate,
            isActive: isActive,
            openingBalance: openingBalance,
            closingBalance: closingBalance,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<double> openingBalance = const Value.absent(),
            Value<double> closingBalance = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BudgetPeriodsCompanion.insert(
            id: id,
            name: name,
            startDate: startDate,
            endDate: endDate,
            isActive: isActive,
            openingBalance: openingBalance,
            closingBalance: closingBalance,
            createdAt: createdAt,
          ),
        ));
}

class $$BudgetPeriodsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BudgetPeriodsTable> {
  $$BudgetPeriodsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startDate => $state.composableBuilder(
      column: $state.table.startDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endDate => $state.composableBuilder(
      column: $state.table.endDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get openingBalance => $state.composableBuilder(
      column: $state.table.openingBalance,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get closingBalance => $state.composableBuilder(
      column: $state.table.closingBalance,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter paymentsRefs(
      ComposableFilter Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.payments,
        getReferencedColumn: (t) => t.periodId,
        builder: (joinBuilder, parentComposers) =>
            $$PaymentsTableFilterComposer(ComposerState(
                $state.db, $state.db.payments, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter transactionsRefs(
      ComposableFilter Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.transactions,
        getReferencedColumn: (t) => t.periodId,
        builder: (joinBuilder, parentComposers) =>
            $$TransactionsTableFilterComposer(ComposerState($state.db,
                $state.db.transactions, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$BudgetPeriodsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BudgetPeriodsTable> {
  $$BudgetPeriodsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startDate => $state.composableBuilder(
      column: $state.table.startDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endDate => $state.composableBuilder(
      column: $state.table.endDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get openingBalance => $state.composableBuilder(
      column: $state.table.openingBalance,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get closingBalance => $state.composableBuilder(
      column: $state.table.closingBalance,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int jobId,
  Value<int?> periodId,
  Value<String> type,
  required double amount,
  Value<DateTime> paymentDate,
  Value<String> method,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> jobId,
  Value<int?> periodId,
  Value<String> type,
  Value<double> amount,
  Value<DateTime> paymentDate,
  Value<String> method,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PaymentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PaymentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> jobId = const Value.absent(),
            Value<int?> periodId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            jobId: jobId,
            periodId: periodId,
            type: type,
            amount: amount,
            paymentDate: paymentDate,
            method: method,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int jobId,
            Value<int?> periodId = const Value.absent(),
            Value<String> type = const Value.absent(),
            required double amount,
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            jobId: jobId,
            periodId: periodId,
            type: type,
            amount: amount,
            paymentDate: paymentDate,
            method: method,
            notes: notes,
            createdAt: createdAt,
          ),
        ));
}

class $$PaymentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get paymentDate => $state.composableBuilder(
      column: $state.table.paymentDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get method => $state.composableBuilder(
      column: $state.table.method,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }

  $$BudgetPeriodsTableFilterComposer get periodId {
    final $$BudgetPeriodsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.periodId,
        referencedTable: $state.db.budgetPeriods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$BudgetPeriodsTableFilterComposer(ComposerState($state.db,
                $state.db.budgetPeriods, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get paymentDate => $state.composableBuilder(
      column: $state.table.paymentDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get method => $state.composableBuilder(
      column: $state.table.method,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.jobId,
        referencedTable: $state.db.jobs,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$JobsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.jobs, joinBuilder, parentComposers)));
    return composer;
  }

  $$BudgetPeriodsTableOrderingComposer get periodId {
    final $$BudgetPeriodsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.periodId,
            referencedTable: $state.db.budgetPeriods,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$BudgetPeriodsTableOrderingComposer(ComposerState($state.db,
                    $state.db.budgetPeriods, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int?> periodId,
  required String title,
  Value<String> type,
  required double amount,
  Value<DateTime> date,
  Value<String?> category,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<int?> periodId,
  Value<String> title,
  Value<String> type,
  Value<double> amount,
  Value<DateTime> date,
  Value<String?> category,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TransactionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TransactionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> periodId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            periodId: periodId,
            title: title,
            type: type,
            amount: amount,
            date: date,
            category: category,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> periodId = const Value.absent(),
            required String title,
            Value<String> type = const Value.absent(),
            required double amount,
            Value<DateTime> date = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            periodId: periodId,
            title: title,
            type: type,
            amount: amount,
            date: date,
            category: category,
            notes: notes,
            createdAt: createdAt,
          ),
        ));
}

class $$TransactionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$BudgetPeriodsTableFilterComposer get periodId {
    final $$BudgetPeriodsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.periodId,
        referencedTable: $state.db.budgetPeriods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$BudgetPeriodsTableFilterComposer(ComposerState($state.db,
                $state.db.budgetPeriods, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$BudgetPeriodsTableOrderingComposer get periodId {
    final $$BudgetPeriodsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.periodId,
            referencedTable: $state.db.budgetPeriods,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$BudgetPeriodsTableOrderingComposer(ComposerState($state.db,
                    $state.db.budgetPeriods, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$LineItemsTableTableManager get lineItems =>
      $$LineItemsTableTableManager(_db, _db.lineItems);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$JobImagesTableTableManager get jobImages =>
      $$JobImagesTableTableManager(_db, _db.jobImages);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$MaterialTemplatesTableTableManager get materialTemplates =>
      $$MaterialTemplatesTableTableManager(_db, _db.materialTemplates);
  $$BudgetPeriodsTableTableManager get budgetPeriods =>
      $$BudgetPeriodsTableTableManager(_db, _db.budgetPeriods);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
