// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Categorie extends DataClass implements Insertable<Categorie> {
  final int id;
  final String name;
  final String imageurl;
  Categorie({@required this.id, @required this.name, @required this.imageurl});
  factory Categorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Categorie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      imageurl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}imageurl']),
    );
  }
  factory Categorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Categorie(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageurl: serializer.fromJson<String>(json['imageurl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageurl': serializer.toJson<String>(imageurl),
    };
  }

  @override
  CategoriesCompanion createCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imageurl: imageurl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageurl),
    );
  }

  Categorie copyWith({int id, String name, String imageurl}) => Categorie(
        id: id ?? this.id,
        name: name ?? this.name,
        imageurl: imageurl ?? this.imageurl,
      );
  @override
  String toString() {
    return (StringBuffer('Categorie(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageurl: $imageurl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, imageurl.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Categorie &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageurl == this.imageurl);
}

class CategoriesCompanion extends UpdateCompanion<Categorie> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageurl;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageurl = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String imageurl,
  })  : name = Value(name),
        imageurl = Value(imageurl);
  CategoriesCompanion copyWith(
      {Value<int> id, Value<String> name, Value<String> imageurl}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageurl: imageurl ?? this.imageurl,
    );
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Categorie> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _imageurlMeta = const VerificationMeta('imageurl');
  GeneratedTextColumn _imageurl;
  @override
  GeneratedTextColumn get imageurl => _imageurl ??= _constructImageurl();
  GeneratedTextColumn _constructImageurl() {
    return GeneratedTextColumn('imageurl', $tableName, false,
        minTextLength: 1, maxTextLength: 1000);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, imageurl];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(CategoriesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.imageurl.present) {
      context.handle(_imageurlMeta,
          imageurl.isAcceptableValue(d.imageurl.value, _imageurlMeta));
    } else if (isInserting) {
      context.missing(_imageurlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categorie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Categorie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoriesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.imageurl.present) {
      map['imageurl'] = Variable<String, StringType>(d.imageurl.value);
    }
    return map;
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class Colore extends DataClass implements Insertable<Colore> {
  final int id;
  final String name;
  final String value;
  Colore({@required this.id, @required this.name, @required this.value});
  factory Colore.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Colore(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      value:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
    );
  }
  factory Colore.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Colore(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  @override
  ColoresCompanion createCompanion(bool nullToAbsent) {
    return ColoresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  Colore copyWith({int id, String name, String value}) => Colore(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Colore(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, value.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Colore &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value);
}

class ColoresCompanion extends UpdateCompanion<Colore> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> value;
  const ColoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
  });
  ColoresCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String value,
  })  : name = Value(name),
        value = Value(value);
  ColoresCompanion copyWith(
      {Value<int> id, Value<String> name, Value<String> value}) {
    return ColoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}

class $ColoresTable extends Colores with TableInfo<$ColoresTable, Colore> {
  final GeneratedDatabase _db;
  final String _alias;
  $ColoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedTextColumn _value;
  @override
  GeneratedTextColumn get value => _value ??= _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn('value', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, value];
  @override
  $ColoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'colores';
  @override
  final String actualTableName = 'colores';
  @override
  VerificationContext validateIntegrity(ColoresCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.value.present) {
      context.handle(
          _valueMeta, value.isAcceptableValue(d.value.value, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Colore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Colore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ColoresCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.value.present) {
      map['value'] = Variable<String, StringType>(d.value.value);
    }
    return map;
  }

  @override
  $ColoresTable createAlias(String alias) {
    return $ColoresTable(_db, alias);
  }
}

class Proveedore extends DataClass implements Insertable<Proveedore> {
  final int id;
  final String name;
  final String phone;
  final String email;
  Proveedore({@required this.id, @required this.name, this.phone, this.email});
  factory Proveedore.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Proveedore(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      phone:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}phone']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
    );
  }
  factory Proveedore.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Proveedore(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
    };
  }

  @override
  ProveedoresCompanion createCompanion(bool nullToAbsent) {
    return ProveedoresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  Proveedore copyWith({int id, String name, String phone, String email}) =>
      Proveedore(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('Proveedore(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(phone.hashCode, email.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Proveedore &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email);
}

class ProveedoresCompanion extends UpdateCompanion<Proveedore> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> email;
  const ProveedoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  ProveedoresCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  }) : name = Value(name);
  ProveedoresCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String> email}) {
    return ProveedoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}

class $ProveedoresTable extends Proveedores
    with TableInfo<$ProveedoresTable, Proveedore> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProveedoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  GeneratedTextColumn _phone;
  @override
  GeneratedTextColumn get phone => _phone ??= _constructPhone();
  GeneratedTextColumn _constructPhone() {
    return GeneratedTextColumn(
      'phone',
      $tableName,
      true,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, phone, email];
  @override
  $ProveedoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'proveedores';
  @override
  final String actualTableName = 'proveedores';
  @override
  VerificationContext validateIntegrity(ProveedoresCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.phone.present) {
      context.handle(
          _phoneMeta, phone.isAcceptableValue(d.phone.value, _phoneMeta));
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Proveedore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Proveedore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProveedoresCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.phone.present) {
      map['phone'] = Variable<String, StringType>(d.phone.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    return map;
  }

  @override
  $ProveedoresTable createAlias(String alias) {
    return $ProveedoresTable(_db, alias);
  }
}

class Talla extends DataClass implements Insertable<Talla> {
  final int id;
  final String size;
  Talla({@required this.id, @required this.size});
  factory Talla.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Talla(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      size: stringType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
    );
  }
  factory Talla.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Talla(
      id: serializer.fromJson<int>(json['id']),
      size: serializer.fromJson<String>(json['size']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'size': serializer.toJson<String>(size),
    };
  }

  @override
  TallasCompanion createCompanion(bool nullToAbsent) {
    return TallasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
    );
  }

  Talla copyWith({int id, String size}) => Talla(
        id: id ?? this.id,
        size: size ?? this.size,
      );
  @override
  String toString() {
    return (StringBuffer('Talla(')
          ..write('id: $id, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, size.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Talla && other.id == this.id && other.size == this.size);
}

class TallasCompanion extends UpdateCompanion<Talla> {
  final Value<int> id;
  final Value<String> size;
  const TallasCompanion({
    this.id = const Value.absent(),
    this.size = const Value.absent(),
  });
  TallasCompanion.insert({
    this.id = const Value.absent(),
    @required String size,
  }) : size = Value(size);
  TallasCompanion copyWith({Value<int> id, Value<String> size}) {
    return TallasCompanion(
      id: id ?? this.id,
      size: size ?? this.size,
    );
  }
}

class $TallasTable extends Tallas with TableInfo<$TallasTable, Talla> {
  final GeneratedDatabase _db;
  final String _alias;
  $TallasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedTextColumn _size;
  @override
  GeneratedTextColumn get size => _size ??= _constructSize();
  GeneratedTextColumn _constructSize() {
    return GeneratedTextColumn('size', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, size];
  @override
  $TallasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tallas';
  @override
  final String actualTableName = 'tallas';
  @override
  VerificationContext validateIntegrity(TallasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.size.present) {
      context.handle(
          _sizeMeta, size.isAcceptableValue(d.size.value, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Talla map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Talla.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TallasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.size.present) {
      map['size'] = Variable<String, StringType>(d.size.value);
    }
    return map;
  }

  @override
  $TallasTable createAlias(String alias) {
    return $TallasTable(_db, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final int id;
  final String codigo;
  final double precioUnitario;
  final double precioDocena;
  final double precioMayorista;
  final double precioYarda;
  final double precioCien;
  final double precio500U;
  final double precioCaja;
  final double precioFardo;
  final double precioRollo;
  final int providerId;
  final int categoryId;
  final String specifications;
  Producto(
      {@required this.id,
      @required this.codigo,
      this.precioUnitario,
      this.precioDocena,
      this.precioMayorista,
      this.precioYarda,
      this.precioCien,
      this.precio500U,
      this.precioCaja,
      this.precioFardo,
      this.precioRollo,
      this.providerId,
      this.categoryId,
      @required this.specifications});
  factory Producto.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Producto(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      codigo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      precioUnitario: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_unitario']),
      precioDocena: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_docena']),
      precioMayorista: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_mayorista']),
      precioYarda: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_yarda']),
      precioCien: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_cien']),
      precio500U: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio500_u']),
      precioCaja: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_caja']),
      precioFardo: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_fardo']),
      precioRollo: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}precio_rollo']),
      providerId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}provider_id']),
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      specifications: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}specifications']),
    );
  }
  factory Producto.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Producto(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
      precioDocena: serializer.fromJson<double>(json['precioDocena']),
      precioMayorista: serializer.fromJson<double>(json['precioMayorista']),
      precioYarda: serializer.fromJson<double>(json['precioYarda']),
      precioCien: serializer.fromJson<double>(json['precioCien']),
      precio500U: serializer.fromJson<double>(json['precio500U']),
      precioCaja: serializer.fromJson<double>(json['precioCaja']),
      precioFardo: serializer.fromJson<double>(json['precioFardo']),
      precioRollo: serializer.fromJson<double>(json['precioRollo']),
      providerId: serializer.fromJson<int>(json['providerId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      specifications: serializer.fromJson<String>(json['specifications']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String>(codigo),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
      'precioDocena': serializer.toJson<double>(precioDocena),
      'precioMayorista': serializer.toJson<double>(precioMayorista),
      'precioYarda': serializer.toJson<double>(precioYarda),
      'precioCien': serializer.toJson<double>(precioCien),
      'precio500U': serializer.toJson<double>(precio500U),
      'precioCaja': serializer.toJson<double>(precioCaja),
      'precioFardo': serializer.toJson<double>(precioFardo),
      'precioRollo': serializer.toJson<double>(precioRollo),
      'providerId': serializer.toJson<int>(providerId),
      'categoryId': serializer.toJson<int>(categoryId),
      'specifications': serializer.toJson<String>(specifications),
    };
  }

  @override
  ProductosCompanion createCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      precioUnitario: precioUnitario == null && nullToAbsent
          ? const Value.absent()
          : Value(precioUnitario),
      precioDocena: precioDocena == null && nullToAbsent
          ? const Value.absent()
          : Value(precioDocena),
      precioMayorista: precioMayorista == null && nullToAbsent
          ? const Value.absent()
          : Value(precioMayorista),
      precioYarda: precioYarda == null && nullToAbsent
          ? const Value.absent()
          : Value(precioYarda),
      precioCien: precioCien == null && nullToAbsent
          ? const Value.absent()
          : Value(precioCien),
      precio500U: precio500U == null && nullToAbsent
          ? const Value.absent()
          : Value(precio500U),
      precioCaja: precioCaja == null && nullToAbsent
          ? const Value.absent()
          : Value(precioCaja),
      precioFardo: precioFardo == null && nullToAbsent
          ? const Value.absent()
          : Value(precioFardo),
      precioRollo: precioRollo == null && nullToAbsent
          ? const Value.absent()
          : Value(precioRollo),
      providerId: providerId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      specifications: specifications == null && nullToAbsent
          ? const Value.absent()
          : Value(specifications),
    );
  }

  Producto copyWith(
          {int id,
          String codigo,
          double precioUnitario,
          double precioDocena,
          double precioMayorista,
          double precioYarda,
          double precioCien,
          double precio500U,
          double precioCaja,
          double precioFardo,
          double precioRollo,
          int providerId,
          int categoryId,
          String specifications}) =>
      Producto(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        precioUnitario: precioUnitario ?? this.precioUnitario,
        precioDocena: precioDocena ?? this.precioDocena,
        precioMayorista: precioMayorista ?? this.precioMayorista,
        precioYarda: precioYarda ?? this.precioYarda,
        precioCien: precioCien ?? this.precioCien,
        precio500U: precio500U ?? this.precio500U,
        precioCaja: precioCaja ?? this.precioCaja,
        precioFardo: precioFardo ?? this.precioFardo,
        precioRollo: precioRollo ?? this.precioRollo,
        providerId: providerId ?? this.providerId,
        categoryId: categoryId ?? this.categoryId,
        specifications: specifications ?? this.specifications,
      );
  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('precioDocena: $precioDocena, ')
          ..write('precioMayorista: $precioMayorista, ')
          ..write('precioYarda: $precioYarda, ')
          ..write('precioCien: $precioCien, ')
          ..write('precio500U: $precio500U, ')
          ..write('precioCaja: $precioCaja, ')
          ..write('precioFardo: $precioFardo, ')
          ..write('precioRollo: $precioRollo, ')
          ..write('providerId: $providerId, ')
          ..write('categoryId: $categoryId, ')
          ..write('specifications: $specifications')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          codigo.hashCode,
          $mrjc(
              precioUnitario.hashCode,
              $mrjc(
                  precioDocena.hashCode,
                  $mrjc(
                      precioMayorista.hashCode,
                      $mrjc(
                          precioYarda.hashCode,
                          $mrjc(
                              precioCien.hashCode,
                              $mrjc(
                                  precio500U.hashCode,
                                  $mrjc(
                                      precioCaja.hashCode,
                                      $mrjc(
                                          precioFardo.hashCode,
                                          $mrjc(
                                              precioRollo.hashCode,
                                              $mrjc(
                                                  providerId.hashCode,
                                                  $mrjc(
                                                      categoryId.hashCode,
                                                      specifications
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Producto &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.precioUnitario == this.precioUnitario &&
          other.precioDocena == this.precioDocena &&
          other.precioMayorista == this.precioMayorista &&
          other.precioYarda == this.precioYarda &&
          other.precioCien == this.precioCien &&
          other.precio500U == this.precio500U &&
          other.precioCaja == this.precioCaja &&
          other.precioFardo == this.precioFardo &&
          other.precioRollo == this.precioRollo &&
          other.providerId == this.providerId &&
          other.categoryId == this.categoryId &&
          other.specifications == this.specifications);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<int> id;
  final Value<String> codigo;
  final Value<double> precioUnitario;
  final Value<double> precioDocena;
  final Value<double> precioMayorista;
  final Value<double> precioYarda;
  final Value<double> precioCien;
  final Value<double> precio500U;
  final Value<double> precioCaja;
  final Value<double> precioFardo;
  final Value<double> precioRollo;
  final Value<int> providerId;
  final Value<int> categoryId;
  final Value<String> specifications;
  const ProductosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.precioUnitario = const Value.absent(),
    this.precioDocena = const Value.absent(),
    this.precioMayorista = const Value.absent(),
    this.precioYarda = const Value.absent(),
    this.precioCien = const Value.absent(),
    this.precio500U = const Value.absent(),
    this.precioCaja = const Value.absent(),
    this.precioFardo = const Value.absent(),
    this.precioRollo = const Value.absent(),
    this.providerId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.specifications = const Value.absent(),
  });
  ProductosCompanion.insert({
    this.id = const Value.absent(),
    @required String codigo,
    this.precioUnitario = const Value.absent(),
    this.precioDocena = const Value.absent(),
    this.precioMayorista = const Value.absent(),
    this.precioYarda = const Value.absent(),
    this.precioCien = const Value.absent(),
    this.precio500U = const Value.absent(),
    this.precioCaja = const Value.absent(),
    this.precioFardo = const Value.absent(),
    this.precioRollo = const Value.absent(),
    this.providerId = const Value.absent(),
    this.categoryId = const Value.absent(),
    @required String specifications,
  })  : codigo = Value(codigo),
        specifications = Value(specifications);
  ProductosCompanion copyWith(
      {Value<int> id,
      Value<String> codigo,
      Value<double> precioUnitario,
      Value<double> precioDocena,
      Value<double> precioMayorista,
      Value<double> precioYarda,
      Value<double> precioCien,
      Value<double> precio500U,
      Value<double> precioCaja,
      Value<double> precioFardo,
      Value<double> precioRollo,
      Value<int> providerId,
      Value<int> categoryId,
      Value<String> specifications}) {
    return ProductosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      precioDocena: precioDocena ?? this.precioDocena,
      precioMayorista: precioMayorista ?? this.precioMayorista,
      precioYarda: precioYarda ?? this.precioYarda,
      precioCien: precioCien ?? this.precioCien,
      precio500U: precio500U ?? this.precio500U,
      precioCaja: precioCaja ?? this.precioCaja,
      precioFardo: precioFardo ?? this.precioFardo,
      precioRollo: precioRollo ?? this.precioRollo,
      providerId: providerId ?? this.providerId,
      categoryId: categoryId ?? this.categoryId,
      specifications: specifications ?? this.specifications,
    );
  }
}

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  GeneratedTextColumn _codigo;
  @override
  GeneratedTextColumn get codigo => _codigo ??= _constructCodigo();
  GeneratedTextColumn _constructCodigo() {
    return GeneratedTextColumn('codigo', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _precioUnitarioMeta =
      const VerificationMeta('precioUnitario');
  GeneratedRealColumn _precioUnitario;
  @override
  GeneratedRealColumn get precioUnitario =>
      _precioUnitario ??= _constructPrecioUnitario();
  GeneratedRealColumn _constructPrecioUnitario() {
    return GeneratedRealColumn(
      'precio_unitario',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioDocenaMeta =
      const VerificationMeta('precioDocena');
  GeneratedRealColumn _precioDocena;
  @override
  GeneratedRealColumn get precioDocena =>
      _precioDocena ??= _constructPrecioDocena();
  GeneratedRealColumn _constructPrecioDocena() {
    return GeneratedRealColumn(
      'precio_docena',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioMayoristaMeta =
      const VerificationMeta('precioMayorista');
  GeneratedRealColumn _precioMayorista;
  @override
  GeneratedRealColumn get precioMayorista =>
      _precioMayorista ??= _constructPrecioMayorista();
  GeneratedRealColumn _constructPrecioMayorista() {
    return GeneratedRealColumn(
      'precio_mayorista',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioYardaMeta =
      const VerificationMeta('precioYarda');
  GeneratedRealColumn _precioYarda;
  @override
  GeneratedRealColumn get precioYarda =>
      _precioYarda ??= _constructPrecioYarda();
  GeneratedRealColumn _constructPrecioYarda() {
    return GeneratedRealColumn(
      'precio_yarda',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioCienMeta = const VerificationMeta('precioCien');
  GeneratedRealColumn _precioCien;
  @override
  GeneratedRealColumn get precioCien => _precioCien ??= _constructPrecioCien();
  GeneratedRealColumn _constructPrecioCien() {
    return GeneratedRealColumn(
      'precio_cien',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precio500UMeta = const VerificationMeta('precio500U');
  GeneratedRealColumn _precio500U;
  @override
  GeneratedRealColumn get precio500U => _precio500U ??= _constructPrecio500U();
  GeneratedRealColumn _constructPrecio500U() {
    return GeneratedRealColumn(
      'precio500_u',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioCajaMeta = const VerificationMeta('precioCaja');
  GeneratedRealColumn _precioCaja;
  @override
  GeneratedRealColumn get precioCaja => _precioCaja ??= _constructPrecioCaja();
  GeneratedRealColumn _constructPrecioCaja() {
    return GeneratedRealColumn(
      'precio_caja',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioFardoMeta =
      const VerificationMeta('precioFardo');
  GeneratedRealColumn _precioFardo;
  @override
  GeneratedRealColumn get precioFardo =>
      _precioFardo ??= _constructPrecioFardo();
  GeneratedRealColumn _constructPrecioFardo() {
    return GeneratedRealColumn(
      'precio_fardo',
      $tableName,
      true,
    );
  }

  final VerificationMeta _precioRolloMeta =
      const VerificationMeta('precioRollo');
  GeneratedRealColumn _precioRollo;
  @override
  GeneratedRealColumn get precioRollo =>
      _precioRollo ??= _constructPrecioRollo();
  GeneratedRealColumn _constructPrecioRollo() {
    return GeneratedRealColumn(
      'precio_rollo',
      $tableName,
      true,
    );
  }

  final VerificationMeta _providerIdMeta = const VerificationMeta('providerId');
  GeneratedIntColumn _providerId;
  @override
  GeneratedIntColumn get providerId => _providerId ??= _constructProviderId();
  GeneratedIntColumn _constructProviderId() {
    return GeneratedIntColumn('provider_id', $tableName, true,
        $customConstraints: 'NULL REFERENCES proveedores(id)');
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedIntColumn _categoryId;
  @override
  GeneratedIntColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn('category_id', $tableName, true,
        $customConstraints: 'NULL REFERENCES categories(id)');
  }

  final VerificationMeta _specificationsMeta =
      const VerificationMeta('specifications');
  GeneratedTextColumn _specifications;
  @override
  GeneratedTextColumn get specifications =>
      _specifications ??= _constructSpecifications();
  GeneratedTextColumn _constructSpecifications() {
    return GeneratedTextColumn('specifications', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigo,
        precioUnitario,
        precioDocena,
        precioMayorista,
        precioYarda,
        precioCien,
        precio500U,
        precioCaja,
        precioFardo,
        precioRollo,
        providerId,
        categoryId,
        specifications
      ];
  @override
  $ProductosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'productos';
  @override
  final String actualTableName = 'productos';
  @override
  VerificationContext validateIntegrity(ProductosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.codigo.present) {
      context.handle(
          _codigoMeta, codigo.isAcceptableValue(d.codigo.value, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (d.precioUnitario.present) {
      context.handle(
          _precioUnitarioMeta,
          precioUnitario.isAcceptableValue(
              d.precioUnitario.value, _precioUnitarioMeta));
    }
    if (d.precioDocena.present) {
      context.handle(
          _precioDocenaMeta,
          precioDocena.isAcceptableValue(
              d.precioDocena.value, _precioDocenaMeta));
    }
    if (d.precioMayorista.present) {
      context.handle(
          _precioMayoristaMeta,
          precioMayorista.isAcceptableValue(
              d.precioMayorista.value, _precioMayoristaMeta));
    }
    if (d.precioYarda.present) {
      context.handle(_precioYardaMeta,
          precioYarda.isAcceptableValue(d.precioYarda.value, _precioYardaMeta));
    }
    if (d.precioCien.present) {
      context.handle(_precioCienMeta,
          precioCien.isAcceptableValue(d.precioCien.value, _precioCienMeta));
    }
    if (d.precio500U.present) {
      context.handle(_precio500UMeta,
          precio500U.isAcceptableValue(d.precio500U.value, _precio500UMeta));
    }
    if (d.precioCaja.present) {
      context.handle(_precioCajaMeta,
          precioCaja.isAcceptableValue(d.precioCaja.value, _precioCajaMeta));
    }
    if (d.precioFardo.present) {
      context.handle(_precioFardoMeta,
          precioFardo.isAcceptableValue(d.precioFardo.value, _precioFardoMeta));
    }
    if (d.precioRollo.present) {
      context.handle(_precioRolloMeta,
          precioRollo.isAcceptableValue(d.precioRollo.value, _precioRolloMeta));
    }
    if (d.providerId.present) {
      context.handle(_providerIdMeta,
          providerId.isAcceptableValue(d.providerId.value, _providerIdMeta));
    }
    if (d.categoryId.present) {
      context.handle(_categoryIdMeta,
          categoryId.isAcceptableValue(d.categoryId.value, _categoryIdMeta));
    }
    if (d.specifications.present) {
      context.handle(
          _specificationsMeta,
          specifications.isAcceptableValue(
              d.specifications.value, _specificationsMeta));
    } else if (isInserting) {
      context.missing(_specificationsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Producto.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductosCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.codigo.present) {
      map['codigo'] = Variable<String, StringType>(d.codigo.value);
    }
    if (d.precioUnitario.present) {
      map['precio_unitario'] =
          Variable<double, RealType>(d.precioUnitario.value);
    }
    if (d.precioDocena.present) {
      map['precio_docena'] = Variable<double, RealType>(d.precioDocena.value);
    }
    if (d.precioMayorista.present) {
      map['precio_mayorista'] =
          Variable<double, RealType>(d.precioMayorista.value);
    }
    if (d.precioYarda.present) {
      map['precio_yarda'] = Variable<double, RealType>(d.precioYarda.value);
    }
    if (d.precioCien.present) {
      map['precio_cien'] = Variable<double, RealType>(d.precioCien.value);
    }
    if (d.precio500U.present) {
      map['precio500_u'] = Variable<double, RealType>(d.precio500U.value);
    }
    if (d.precioCaja.present) {
      map['precio_caja'] = Variable<double, RealType>(d.precioCaja.value);
    }
    if (d.precioFardo.present) {
      map['precio_fardo'] = Variable<double, RealType>(d.precioFardo.value);
    }
    if (d.precioRollo.present) {
      map['precio_rollo'] = Variable<double, RealType>(d.precioRollo.value);
    }
    if (d.providerId.present) {
      map['provider_id'] = Variable<int, IntType>(d.providerId.value);
    }
    if (d.categoryId.present) {
      map['category_id'] = Variable<int, IntType>(d.categoryId.value);
    }
    if (d.specifications.present) {
      map['specifications'] =
          Variable<String, StringType>(d.specifications.value);
    }
    return map;
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(_db, alias);
  }
}

class ProductosWithColore extends DataClass
    implements Insertable<ProductosWithColore> {
  final int id;
  final int producto;
  final int color;
  ProductosWithColore(
      {@required this.id, @required this.producto, @required this.color});
  factory ProductosWithColore.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductosWithColore(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      producto:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}producto']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  factory ProductosWithColore.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductosWithColore(
      id: serializer.fromJson<int>(json['id']),
      producto: serializer.fromJson<int>(json['producto']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'producto': serializer.toJson<int>(producto),
      'color': serializer.toJson<int>(color),
    };
  }

  @override
  ProductosWithColoresCompanion createCompanion(bool nullToAbsent) {
    return ProductosWithColoresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      producto: producto == null && nullToAbsent
          ? const Value.absent()
          : Value(producto),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  ProductosWithColore copyWith({int id, int producto, int color}) =>
      ProductosWithColore(
        id: id ?? this.id,
        producto: producto ?? this.producto,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('ProductosWithColore(')
          ..write('id: $id, ')
          ..write('producto: $producto, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(producto.hashCode, color.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductosWithColore &&
          other.id == this.id &&
          other.producto == this.producto &&
          other.color == this.color);
}

class ProductosWithColoresCompanion
    extends UpdateCompanion<ProductosWithColore> {
  final Value<int> id;
  final Value<int> producto;
  final Value<int> color;
  const ProductosWithColoresCompanion({
    this.id = const Value.absent(),
    this.producto = const Value.absent(),
    this.color = const Value.absent(),
  });
  ProductosWithColoresCompanion.insert({
    this.id = const Value.absent(),
    @required int producto,
    @required int color,
  })  : producto = Value(producto),
        color = Value(color);
  ProductosWithColoresCompanion copyWith(
      {Value<int> id, Value<int> producto, Value<int> color}) {
    return ProductosWithColoresCompanion(
      id: id ?? this.id,
      producto: producto ?? this.producto,
      color: color ?? this.color,
    );
  }
}

class $ProductosWithColoresTable extends ProductosWithColores
    with TableInfo<$ProductosWithColoresTable, ProductosWithColore> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductosWithColoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productoMeta = const VerificationMeta('producto');
  GeneratedIntColumn _producto;
  @override
  GeneratedIntColumn get producto => _producto ??= _constructProducto();
  GeneratedIntColumn _constructProducto() {
    return GeneratedIntColumn(
      'producto',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, producto, color];
  @override
  $ProductosWithColoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'productos_with_colores';
  @override
  final String actualTableName = 'productos_with_colores';
  @override
  VerificationContext validateIntegrity(ProductosWithColoresCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.producto.present) {
      context.handle(_productoMeta,
          producto.isAcceptableValue(d.producto.value, _productoMeta));
    } else if (isInserting) {
      context.missing(_productoMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductosWithColore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductosWithColore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductosWithColoresCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.producto.present) {
      map['producto'] = Variable<int, IntType>(d.producto.value);
    }
    if (d.color.present) {
      map['color'] = Variable<int, IntType>(d.color.value);
    }
    return map;
  }

  @override
  $ProductosWithColoresTable createAlias(String alias) {
    return $ProductosWithColoresTable(_db, alias);
  }
}

class ProductosConColoresWithTalla extends DataClass
    implements Insertable<ProductosConColoresWithTalla> {
  final int id;
  final int productoConColores;
  final int tallas;
  ProductosConColoresWithTalla(
      {@required this.id,
      @required this.productoConColores,
      @required this.tallas});
  factory ProductosConColoresWithTalla.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductosConColoresWithTalla(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productoConColores: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}producto_con_colores']),
      tallas: intType.mapFromDatabaseResponse(data['${effectivePrefix}tallas']),
    );
  }
  factory ProductosConColoresWithTalla.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductosConColoresWithTalla(
      id: serializer.fromJson<int>(json['id']),
      productoConColores: serializer.fromJson<int>(json['productoConColores']),
      tallas: serializer.fromJson<int>(json['tallas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoConColores': serializer.toJson<int>(productoConColores),
      'tallas': serializer.toJson<int>(tallas),
    };
  }

  @override
  ProductosConColoresWithTallasCompanion createCompanion(bool nullToAbsent) {
    return ProductosConColoresWithTallasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productoConColores: productoConColores == null && nullToAbsent
          ? const Value.absent()
          : Value(productoConColores),
      tallas:
          tallas == null && nullToAbsent ? const Value.absent() : Value(tallas),
    );
  }

  ProductosConColoresWithTalla copyWith(
          {int id, int productoConColores, int tallas}) =>
      ProductosConColoresWithTalla(
        id: id ?? this.id,
        productoConColores: productoConColores ?? this.productoConColores,
        tallas: tallas ?? this.tallas,
      );
  @override
  String toString() {
    return (StringBuffer('ProductosConColoresWithTalla(')
          ..write('id: $id, ')
          ..write('productoConColores: $productoConColores, ')
          ..write('tallas: $tallas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(id.hashCode, $mrjc(productoConColores.hashCode, tallas.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductosConColoresWithTalla &&
          other.id == this.id &&
          other.productoConColores == this.productoConColores &&
          other.tallas == this.tallas);
}

class ProductosConColoresWithTallasCompanion
    extends UpdateCompanion<ProductosConColoresWithTalla> {
  final Value<int> id;
  final Value<int> productoConColores;
  final Value<int> tallas;
  const ProductosConColoresWithTallasCompanion({
    this.id = const Value.absent(),
    this.productoConColores = const Value.absent(),
    this.tallas = const Value.absent(),
  });
  ProductosConColoresWithTallasCompanion.insert({
    this.id = const Value.absent(),
    @required int productoConColores,
    @required int tallas,
  })  : productoConColores = Value(productoConColores),
        tallas = Value(tallas);
  ProductosConColoresWithTallasCompanion copyWith(
      {Value<int> id, Value<int> productoConColores, Value<int> tallas}) {
    return ProductosConColoresWithTallasCompanion(
      id: id ?? this.id,
      productoConColores: productoConColores ?? this.productoConColores,
      tallas: tallas ?? this.tallas,
    );
  }
}

class $ProductosConColoresWithTallasTable extends ProductosConColoresWithTallas
    with
        TableInfo<$ProductosConColoresWithTallasTable,
            ProductosConColoresWithTalla> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductosConColoresWithTallasTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productoConColoresMeta =
      const VerificationMeta('productoConColores');
  GeneratedIntColumn _productoConColores;
  @override
  GeneratedIntColumn get productoConColores =>
      _productoConColores ??= _constructProductoConColores();
  GeneratedIntColumn _constructProductoConColores() {
    return GeneratedIntColumn(
      'producto_con_colores',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tallasMeta = const VerificationMeta('tallas');
  GeneratedIntColumn _tallas;
  @override
  GeneratedIntColumn get tallas => _tallas ??= _constructTallas();
  GeneratedIntColumn _constructTallas() {
    return GeneratedIntColumn(
      'tallas',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, productoConColores, tallas];
  @override
  $ProductosConColoresWithTallasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'productos_con_colores_with_tallas';
  @override
  final String actualTableName = 'productos_con_colores_with_tallas';
  @override
  VerificationContext validateIntegrity(
      ProductosConColoresWithTallasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.productoConColores.present) {
      context.handle(
          _productoConColoresMeta,
          productoConColores.isAcceptableValue(
              d.productoConColores.value, _productoConColoresMeta));
    } else if (isInserting) {
      context.missing(_productoConColoresMeta);
    }
    if (d.tallas.present) {
      context.handle(
          _tallasMeta, tallas.isAcceptableValue(d.tallas.value, _tallasMeta));
    } else if (isInserting) {
      context.missing(_tallasMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductosConColoresWithTalla map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductosConColoresWithTalla.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductosConColoresWithTallasCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.productoConColores.present) {
      map['producto_con_colores'] =
          Variable<int, IntType>(d.productoConColores.value);
    }
    if (d.tallas.present) {
      map['tallas'] = Variable<int, IntType>(d.tallas.value);
    }
    return map;
  }

  @override
  $ProductosConColoresWithTallasTable createAlias(String alias) {
    return $ProductosConColoresWithTallasTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  $ColoresTable _colores;
  $ColoresTable get colores => _colores ??= $ColoresTable(this);
  $ProveedoresTable _proveedores;
  $ProveedoresTable get proveedores => _proveedores ??= $ProveedoresTable(this);
  $TallasTable _tallas;
  $TallasTable get tallas => _tallas ??= $TallasTable(this);
  $ProductosTable _productos;
  $ProductosTable get productos => _productos ??= $ProductosTable(this);
  $ProductosWithColoresTable _productosWithColores;
  $ProductosWithColoresTable get productosWithColores =>
      _productosWithColores ??= $ProductosWithColoresTable(this);
  $ProductosConColoresWithTallasTable _productosConColoresWithTallas;
  $ProductosConColoresWithTallasTable get productosConColoresWithTallas =>
      _productosConColoresWithTallas ??=
          $ProductosConColoresWithTallasTable(this);
  CategoriesDao _categoriesDao;
  CategoriesDao get categoriesDao =>
      _categoriesDao ??= CategoriesDao(this as AppDatabase);
  ColoresDao _coloresDao;
  ColoresDao get coloresDao => _coloresDao ??= ColoresDao(this as AppDatabase);
  TallasDao _tallasDao;
  TallasDao get tallasDao => _tallasDao ??= TallasDao(this as AppDatabase);
  ProveedoresDao _proveedoresDao;
  ProveedoresDao get proveedoresDao =>
      _proveedoresDao ??= ProveedoresDao(this as AppDatabase);
  ProductosDao _productosDao;
  ProductosDao get productosDao =>
      _productosDao ??= ProductosDao(this as AppDatabase);
  ProductosWithColoresDao _productosWithColoresDao;
  ProductosWithColoresDao get productosWithColoresDao =>
      _productosWithColoresDao ??= ProductosWithColoresDao(this as AppDatabase);
  ProductosConColoresWithTallasDao _productosConColoresWithTallasDao;
  ProductosConColoresWithTallasDao get productosConColoresWithTallasDao =>
      _productosConColoresWithTallasDao ??=
          ProductosConColoresWithTallasDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        categories,
        colores,
        proveedores,
        tallas,
        productos,
        productosWithColores,
        productosConColoresWithTallas
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$CategoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTable get categories => db.categories;
}
mixin _$ColoresDaoMixin on DatabaseAccessor<AppDatabase> {
  $ColoresTable get colores => db.colores;
}
mixin _$TallasDaoMixin on DatabaseAccessor<AppDatabase> {
  $TallasTable get tallas => db.tallas;
}
mixin _$ProveedoresDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProveedoresTable get proveedores => db.proveedores;
}
mixin _$ProductosDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductosTable get productos => db.productos;
}
mixin _$ProductosWithColoresDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductosWithColoresTable get productosWithColores =>
      db.productosWithColores;
  $ProductosTable get productos => db.productos;
  $ColoresTable get colores => db.colores;
}
mixin _$ProductosConColoresWithTallasDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductosWithColoresTable get productosWithColores =>
      db.productosWithColores;
  $ProductosConColoresWithTallasTable get productosConColoresWithTallas =>
      db.productosConColoresWithTallas;
  $TallasTable get tallas => db.tallas;
}
