// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Categorie extends DataClass implements Insertable<Categorie> {
  final int idCategory;
  final String name;
  final String imageurl;
  Categorie(
      {@required this.idCategory,
      @required this.name,
      @required this.imageurl});
  factory Categorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Categorie(
      idCategory: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_category']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      imageurl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}imageurl']),
    );
  }
  factory Categorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Categorie(
      idCategory: serializer.fromJson<int>(json['idCategory']),
      name: serializer.fromJson<String>(json['name']),
      imageurl: serializer.fromJson<String>(json['imageurl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idCategory': serializer.toJson<int>(idCategory),
      'name': serializer.toJson<String>(name),
      'imageurl': serializer.toJson<String>(imageurl),
    };
  }

  @override
  CategoriesCompanion createCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      idCategory: idCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(idCategory),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imageurl: imageurl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageurl),
    );
  }

  Categorie copyWith({int idCategory, String name, String imageurl}) =>
      Categorie(
        idCategory: idCategory ?? this.idCategory,
        name: name ?? this.name,
        imageurl: imageurl ?? this.imageurl,
      );
  @override
  String toString() {
    return (StringBuffer('Categorie(')
          ..write('idCategory: $idCategory, ')
          ..write('name: $name, ')
          ..write('imageurl: $imageurl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(idCategory.hashCode, $mrjc(name.hashCode, imageurl.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Categorie &&
          other.idCategory == this.idCategory &&
          other.name == this.name &&
          other.imageurl == this.imageurl);
}

class CategoriesCompanion extends UpdateCompanion<Categorie> {
  final Value<int> idCategory;
  final Value<String> name;
  final Value<String> imageurl;
  const CategoriesCompanion({
    this.idCategory = const Value.absent(),
    this.name = const Value.absent(),
    this.imageurl = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.idCategory = const Value.absent(),
    @required String name,
    @required String imageurl,
  })  : name = Value(name),
        imageurl = Value(imageurl);
  CategoriesCompanion copyWith(
      {Value<int> idCategory, Value<String> name, Value<String> imageurl}) {
    return CategoriesCompanion(
      idCategory: idCategory ?? this.idCategory,
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
  final VerificationMeta _idCategoryMeta = const VerificationMeta('idCategory');
  GeneratedIntColumn _idCategory;
  @override
  GeneratedIntColumn get idCategory => _idCategory ??= _constructIdCategory();
  GeneratedIntColumn _constructIdCategory() {
    return GeneratedIntColumn('id_category', $tableName, false,
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
  List<GeneratedColumn> get $columns => [idCategory, name, imageurl];
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
    if (d.idCategory.present) {
      context.handle(_idCategoryMeta,
          idCategory.isAcceptableValue(d.idCategory.value, _idCategoryMeta));
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
  Set<GeneratedColumn> get $primaryKey => {idCategory};
  @override
  Categorie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Categorie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoriesCompanion d) {
    final map = <String, Variable>{};
    if (d.idCategory.present) {
      map['id_category'] = Variable<int, IntType>(d.idCategory.value);
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
  final int idColor;
  final String name;
  final String value;
  Colore({@required this.idColor, @required this.name, @required this.value});
  factory Colore.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Colore(
      idColor:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_color']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      value:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
    );
  }
  factory Colore.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Colore(
      idColor: serializer.fromJson<int>(json['idColor']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idColor': serializer.toJson<int>(idColor),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  @override
  ColoresCompanion createCompanion(bool nullToAbsent) {
    return ColoresCompanion(
      idColor: idColor == null && nullToAbsent
          ? const Value.absent()
          : Value(idColor),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  Colore copyWith({int idColor, String name, String value}) => Colore(
        idColor: idColor ?? this.idColor,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Colore(')
          ..write('idColor: $idColor, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(idColor.hashCode, $mrjc(name.hashCode, value.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Colore &&
          other.idColor == this.idColor &&
          other.name == this.name &&
          other.value == this.value);
}

class ColoresCompanion extends UpdateCompanion<Colore> {
  final Value<int> idColor;
  final Value<String> name;
  final Value<String> value;
  const ColoresCompanion({
    this.idColor = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
  });
  ColoresCompanion.insert({
    this.idColor = const Value.absent(),
    @required String name,
    @required String value,
  })  : name = Value(name),
        value = Value(value);
  ColoresCompanion copyWith(
      {Value<int> idColor, Value<String> name, Value<String> value}) {
    return ColoresCompanion(
      idColor: idColor ?? this.idColor,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}

class $ColoresTable extends Colores with TableInfo<$ColoresTable, Colore> {
  final GeneratedDatabase _db;
  final String _alias;
  $ColoresTable(this._db, [this._alias]);
  final VerificationMeta _idColorMeta = const VerificationMeta('idColor');
  GeneratedIntColumn _idColor;
  @override
  GeneratedIntColumn get idColor => _idColor ??= _constructIdColor();
  GeneratedIntColumn _constructIdColor() {
    return GeneratedIntColumn('id_color', $tableName, false,
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
  List<GeneratedColumn> get $columns => [idColor, name, value];
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
    if (d.idColor.present) {
      context.handle(_idColorMeta,
          idColor.isAcceptableValue(d.idColor.value, _idColorMeta));
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
  Set<GeneratedColumn> get $primaryKey => {idColor};
  @override
  Colore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Colore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ColoresCompanion d) {
    final map = <String, Variable>{};
    if (d.idColor.present) {
      map['id_color'] = Variable<int, IntType>(d.idColor.value);
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
  final int idProveedor;
  final String name;
  final String phone;
  final String email;
  Proveedore(
      {@required this.idProveedor,
      @required this.name,
      this.phone,
      this.email});
  factory Proveedore.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Proveedore(
      idProveedor: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_proveedor']),
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
      idProveedor: serializer.fromJson<int>(json['idProveedor']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idProveedor': serializer.toJson<int>(idProveedor),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
    };
  }

  @override
  ProveedoresCompanion createCompanion(bool nullToAbsent) {
    return ProveedoresCompanion(
      idProveedor: idProveedor == null && nullToAbsent
          ? const Value.absent()
          : Value(idProveedor),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  Proveedore copyWith(
          {int idProveedor, String name, String phone, String email}) =>
      Proveedore(
        idProveedor: idProveedor ?? this.idProveedor,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('Proveedore(')
          ..write('idProveedor: $idProveedor, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(idProveedor.hashCode,
      $mrjc(name.hashCode, $mrjc(phone.hashCode, email.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Proveedore &&
          other.idProveedor == this.idProveedor &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email);
}

class ProveedoresCompanion extends UpdateCompanion<Proveedore> {
  final Value<int> idProveedor;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> email;
  const ProveedoresCompanion({
    this.idProveedor = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  ProveedoresCompanion.insert({
    this.idProveedor = const Value.absent(),
    @required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  }) : name = Value(name);
  ProveedoresCompanion copyWith(
      {Value<int> idProveedor,
      Value<String> name,
      Value<String> phone,
      Value<String> email}) {
    return ProveedoresCompanion(
      idProveedor: idProveedor ?? this.idProveedor,
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
  final VerificationMeta _idProveedorMeta =
      const VerificationMeta('idProveedor');
  GeneratedIntColumn _idProveedor;
  @override
  GeneratedIntColumn get idProveedor =>
      _idProveedor ??= _constructIdProveedor();
  GeneratedIntColumn _constructIdProveedor() {
    return GeneratedIntColumn('id_proveedor', $tableName, false,
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
  List<GeneratedColumn> get $columns => [idProveedor, name, phone, email];
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
    if (d.idProveedor.present) {
      context.handle(_idProveedorMeta,
          idProveedor.isAcceptableValue(d.idProveedor.value, _idProveedorMeta));
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
  Set<GeneratedColumn> get $primaryKey => {idProveedor};
  @override
  Proveedore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Proveedore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProveedoresCompanion d) {
    final map = <String, Variable>{};
    if (d.idProveedor.present) {
      map['id_proveedor'] = Variable<int, IntType>(d.idProveedor.value);
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
  final int idTalla;
  final String size;
  Talla({@required this.idTalla, @required this.size});
  factory Talla.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Talla(
      idTalla:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_talla']),
      size: stringType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
    );
  }
  factory Talla.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Talla(
      idTalla: serializer.fromJson<int>(json['idTalla']),
      size: serializer.fromJson<String>(json['size']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idTalla': serializer.toJson<int>(idTalla),
      'size': serializer.toJson<String>(size),
    };
  }

  @override
  TallasCompanion createCompanion(bool nullToAbsent) {
    return TallasCompanion(
      idTalla: idTalla == null && nullToAbsent
          ? const Value.absent()
          : Value(idTalla),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
    );
  }

  Talla copyWith({int idTalla, String size}) => Talla(
        idTalla: idTalla ?? this.idTalla,
        size: size ?? this.size,
      );
  @override
  String toString() {
    return (StringBuffer('Talla(')
          ..write('idTalla: $idTalla, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(idTalla.hashCode, size.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Talla &&
          other.idTalla == this.idTalla &&
          other.size == this.size);
}

class TallasCompanion extends UpdateCompanion<Talla> {
  final Value<int> idTalla;
  final Value<String> size;
  const TallasCompanion({
    this.idTalla = const Value.absent(),
    this.size = const Value.absent(),
  });
  TallasCompanion.insert({
    this.idTalla = const Value.absent(),
    @required String size,
  }) : size = Value(size);
  TallasCompanion copyWith({Value<int> idTalla, Value<String> size}) {
    return TallasCompanion(
      idTalla: idTalla ?? this.idTalla,
      size: size ?? this.size,
    );
  }
}

class $TallasTable extends Tallas with TableInfo<$TallasTable, Talla> {
  final GeneratedDatabase _db;
  final String _alias;
  $TallasTable(this._db, [this._alias]);
  final VerificationMeta _idTallaMeta = const VerificationMeta('idTalla');
  GeneratedIntColumn _idTalla;
  @override
  GeneratedIntColumn get idTalla => _idTalla ??= _constructIdTalla();
  GeneratedIntColumn _constructIdTalla() {
    return GeneratedIntColumn('id_talla', $tableName, false,
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
  List<GeneratedColumn> get $columns => [idTalla, size];
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
    if (d.idTalla.present) {
      context.handle(_idTallaMeta,
          idTalla.isAcceptableValue(d.idTalla.value, _idTallaMeta));
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
  Set<GeneratedColumn> get $primaryKey => {idTalla};
  @override
  Talla map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Talla.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TallasCompanion d) {
    final map = <String, Variable>{};
    if (d.idTalla.present) {
      map['id_talla'] = Variable<int, IntType>(d.idTalla.value);
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
  final int idProducto;
  final String codigo;
  final String descripcion;
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
      {@required this.idProducto,
      @required this.codigo,
      this.descripcion,
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
      this.specifications});
  factory Producto.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Producto(
      idProducto: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_producto']),
      codigo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      descripcion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}descripcion']),
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
      idProducto: serializer.fromJson<int>(json['idProducto']),
      codigo: serializer.fromJson<String>(json['codigo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
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
      'idProducto': serializer.toJson<int>(idProducto),
      'codigo': serializer.toJson<String>(codigo),
      'descripcion': serializer.toJson<String>(descripcion),
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
      idProducto: idProducto == null && nullToAbsent
          ? const Value.absent()
          : Value(idProducto),
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
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
          {int idProducto,
          String codigo,
          String descripcion,
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
        idProducto: idProducto ?? this.idProducto,
        codigo: codigo ?? this.codigo,
        descripcion: descripcion ?? this.descripcion,
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
          ..write('idProducto: $idProducto, ')
          ..write('codigo: $codigo, ')
          ..write('descripcion: $descripcion, ')
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
      idProducto.hashCode,
      $mrjc(
          codigo.hashCode,
          $mrjc(
              descripcion.hashCode,
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
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Producto &&
          other.idProducto == this.idProducto &&
          other.codigo == this.codigo &&
          other.descripcion == this.descripcion &&
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
  final Value<int> idProducto;
  final Value<String> codigo;
  final Value<String> descripcion;
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
    this.idProducto = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descripcion = const Value.absent(),
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
    this.idProducto = const Value.absent(),
    @required String codigo,
    this.descripcion = const Value.absent(),
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
  }) : codigo = Value(codigo);
  ProductosCompanion copyWith(
      {Value<int> idProducto,
      Value<String> codigo,
      Value<String> descripcion,
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
      idProducto: idProducto ?? this.idProducto,
      codigo: codigo ?? this.codigo,
      descripcion: descripcion ?? this.descripcion,
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
  final VerificationMeta _idProductoMeta = const VerificationMeta('idProducto');
  GeneratedIntColumn _idProducto;
  @override
  GeneratedIntColumn get idProducto => _idProducto ??= _constructIdProducto();
  GeneratedIntColumn _constructIdProducto() {
    return GeneratedIntColumn('id_producto', $tableName, false,
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

  final VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  GeneratedTextColumn _descripcion;
  @override
  GeneratedTextColumn get descripcion =>
      _descripcion ??= _constructDescripcion();
  GeneratedTextColumn _constructDescripcion() {
    return GeneratedTextColumn(
      'descripcion',
      $tableName,
      true,
    );
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
        $customConstraints: 'NULL REFERENCES proveedores(id_proveedor)');
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedIntColumn _categoryId;
  @override
  GeneratedIntColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn('category_id', $tableName, true,
        $customConstraints: 'NULL REFERENCES categories(id_category)');
  }

  final VerificationMeta _specificationsMeta =
      const VerificationMeta('specifications');
  GeneratedTextColumn _specifications;
  @override
  GeneratedTextColumn get specifications =>
      _specifications ??= _constructSpecifications();
  GeneratedTextColumn _constructSpecifications() {
    return GeneratedTextColumn(
      'specifications',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        idProducto,
        codigo,
        descripcion,
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
    if (d.idProducto.present) {
      context.handle(_idProductoMeta,
          idProducto.isAcceptableValue(d.idProducto.value, _idProductoMeta));
    }
    if (d.codigo.present) {
      context.handle(
          _codigoMeta, codigo.isAcceptableValue(d.codigo.value, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (d.descripcion.present) {
      context.handle(_descripcionMeta,
          descripcion.isAcceptableValue(d.descripcion.value, _descripcionMeta));
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idProducto};
  @override
  Producto map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Producto.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductosCompanion d) {
    final map = <String, Variable>{};
    if (d.idProducto.present) {
      map['id_producto'] = Variable<int, IntType>(d.idProducto.value);
    }
    if (d.codigo.present) {
      map['codigo'] = Variable<String, StringType>(d.codigo.value);
    }
    if (d.descripcion.present) {
      map['descripcion'] = Variable<String, StringType>(d.descripcion.value);
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
  final int idProductoWithColor;
  final int producto;
  final int color;
  ProductosWithColore(
      {@required this.idProductoWithColor,
      @required this.producto,
      @required this.color});
  factory ProductosWithColore.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductosWithColore(
      idProductoWithColor: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}id_producto_with_color']),
      producto:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}producto']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  factory ProductosWithColore.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductosWithColore(
      idProductoWithColor:
          serializer.fromJson<int>(json['idProductoWithColor']),
      producto: serializer.fromJson<int>(json['producto']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idProductoWithColor': serializer.toJson<int>(idProductoWithColor),
      'producto': serializer.toJson<int>(producto),
      'color': serializer.toJson<int>(color),
    };
  }

  @override
  ProductosWithColoresCompanion createCompanion(bool nullToAbsent) {
    return ProductosWithColoresCompanion(
      idProductoWithColor: idProductoWithColor == null && nullToAbsent
          ? const Value.absent()
          : Value(idProductoWithColor),
      producto: producto == null && nullToAbsent
          ? const Value.absent()
          : Value(producto),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  ProductosWithColore copyWith(
          {int idProductoWithColor, int producto, int color}) =>
      ProductosWithColore(
        idProductoWithColor: idProductoWithColor ?? this.idProductoWithColor,
        producto: producto ?? this.producto,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('ProductosWithColore(')
          ..write('idProductoWithColor: $idProductoWithColor, ')
          ..write('producto: $producto, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      idProductoWithColor.hashCode, $mrjc(producto.hashCode, color.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductosWithColore &&
          other.idProductoWithColor == this.idProductoWithColor &&
          other.producto == this.producto &&
          other.color == this.color);
}

class ProductosWithColoresCompanion
    extends UpdateCompanion<ProductosWithColore> {
  final Value<int> idProductoWithColor;
  final Value<int> producto;
  final Value<int> color;
  const ProductosWithColoresCompanion({
    this.idProductoWithColor = const Value.absent(),
    this.producto = const Value.absent(),
    this.color = const Value.absent(),
  });
  ProductosWithColoresCompanion.insert({
    this.idProductoWithColor = const Value.absent(),
    @required int producto,
    @required int color,
  })  : producto = Value(producto),
        color = Value(color);
  ProductosWithColoresCompanion copyWith(
      {Value<int> idProductoWithColor, Value<int> producto, Value<int> color}) {
    return ProductosWithColoresCompanion(
      idProductoWithColor: idProductoWithColor ?? this.idProductoWithColor,
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
  final VerificationMeta _idProductoWithColorMeta =
      const VerificationMeta('idProductoWithColor');
  GeneratedIntColumn _idProductoWithColor;
  @override
  GeneratedIntColumn get idProductoWithColor =>
      _idProductoWithColor ??= _constructIdProductoWithColor();
  GeneratedIntColumn _constructIdProductoWithColor() {
    return GeneratedIntColumn('id_producto_with_color', $tableName, false,
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
  List<GeneratedColumn> get $columns => [idProductoWithColor, producto, color];
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
    if (d.idProductoWithColor.present) {
      context.handle(
          _idProductoWithColorMeta,
          idProductoWithColor.isAcceptableValue(
              d.idProductoWithColor.value, _idProductoWithColorMeta));
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
  Set<GeneratedColumn> get $primaryKey => {idProductoWithColor};
  @override
  ProductosWithColore map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductosWithColore.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductosWithColoresCompanion d) {
    final map = <String, Variable>{};
    if (d.idProductoWithColor.present) {
      map['id_producto_with_color'] =
          Variable<int, IntType>(d.idProductoWithColor.value);
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

class ProductosWithTalla extends DataClass
    implements Insertable<ProductosWithTalla> {
  final int idProductoWithTalla;
  final int producto;
  final int talla;
  ProductosWithTalla(
      {@required this.idProductoWithTalla,
      @required this.producto,
      @required this.talla});
  factory ProductosWithTalla.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductosWithTalla(
      idProductoWithTalla: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}id_producto_with_talla']),
      producto:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}producto']),
      talla: intType.mapFromDatabaseResponse(data['${effectivePrefix}talla']),
    );
  }
  factory ProductosWithTalla.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductosWithTalla(
      idProductoWithTalla:
          serializer.fromJson<int>(json['idProductoWithTalla']),
      producto: serializer.fromJson<int>(json['producto']),
      talla: serializer.fromJson<int>(json['talla']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idProductoWithTalla': serializer.toJson<int>(idProductoWithTalla),
      'producto': serializer.toJson<int>(producto),
      'talla': serializer.toJson<int>(talla),
    };
  }

  @override
  ProductosWithTallasCompanion createCompanion(bool nullToAbsent) {
    return ProductosWithTallasCompanion(
      idProductoWithTalla: idProductoWithTalla == null && nullToAbsent
          ? const Value.absent()
          : Value(idProductoWithTalla),
      producto: producto == null && nullToAbsent
          ? const Value.absent()
          : Value(producto),
      talla:
          talla == null && nullToAbsent ? const Value.absent() : Value(talla),
    );
  }

  ProductosWithTalla copyWith(
          {int idProductoWithTalla, int producto, int talla}) =>
      ProductosWithTalla(
        idProductoWithTalla: idProductoWithTalla ?? this.idProductoWithTalla,
        producto: producto ?? this.producto,
        talla: talla ?? this.talla,
      );
  @override
  String toString() {
    return (StringBuffer('ProductosWithTalla(')
          ..write('idProductoWithTalla: $idProductoWithTalla, ')
          ..write('producto: $producto, ')
          ..write('talla: $talla')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      idProductoWithTalla.hashCode, $mrjc(producto.hashCode, talla.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductosWithTalla &&
          other.idProductoWithTalla == this.idProductoWithTalla &&
          other.producto == this.producto &&
          other.talla == this.talla);
}

class ProductosWithTallasCompanion extends UpdateCompanion<ProductosWithTalla> {
  final Value<int> idProductoWithTalla;
  final Value<int> producto;
  final Value<int> talla;
  const ProductosWithTallasCompanion({
    this.idProductoWithTalla = const Value.absent(),
    this.producto = const Value.absent(),
    this.talla = const Value.absent(),
  });
  ProductosWithTallasCompanion.insert({
    this.idProductoWithTalla = const Value.absent(),
    @required int producto,
    @required int talla,
  })  : producto = Value(producto),
        talla = Value(talla);
  ProductosWithTallasCompanion copyWith(
      {Value<int> idProductoWithTalla, Value<int> producto, Value<int> talla}) {
    return ProductosWithTallasCompanion(
      idProductoWithTalla: idProductoWithTalla ?? this.idProductoWithTalla,
      producto: producto ?? this.producto,
      talla: talla ?? this.talla,
    );
  }
}

class $ProductosWithTallasTable extends ProductosWithTallas
    with TableInfo<$ProductosWithTallasTable, ProductosWithTalla> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductosWithTallasTable(this._db, [this._alias]);
  final VerificationMeta _idProductoWithTallaMeta =
      const VerificationMeta('idProductoWithTalla');
  GeneratedIntColumn _idProductoWithTalla;
  @override
  GeneratedIntColumn get idProductoWithTalla =>
      _idProductoWithTalla ??= _constructIdProductoWithTalla();
  GeneratedIntColumn _constructIdProductoWithTalla() {
    return GeneratedIntColumn('id_producto_with_talla', $tableName, false,
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

  final VerificationMeta _tallaMeta = const VerificationMeta('talla');
  GeneratedIntColumn _talla;
  @override
  GeneratedIntColumn get talla => _talla ??= _constructTalla();
  GeneratedIntColumn _constructTalla() {
    return GeneratedIntColumn(
      'talla',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [idProductoWithTalla, producto, talla];
  @override
  $ProductosWithTallasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'productos_with_tallas';
  @override
  final String actualTableName = 'productos_with_tallas';
  @override
  VerificationContext validateIntegrity(ProductosWithTallasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.idProductoWithTalla.present) {
      context.handle(
          _idProductoWithTallaMeta,
          idProductoWithTalla.isAcceptableValue(
              d.idProductoWithTalla.value, _idProductoWithTallaMeta));
    }
    if (d.producto.present) {
      context.handle(_productoMeta,
          producto.isAcceptableValue(d.producto.value, _productoMeta));
    } else if (isInserting) {
      context.missing(_productoMeta);
    }
    if (d.talla.present) {
      context.handle(
          _tallaMeta, talla.isAcceptableValue(d.talla.value, _tallaMeta));
    } else if (isInserting) {
      context.missing(_tallaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idProductoWithTalla};
  @override
  ProductosWithTalla map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductosWithTalla.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductosWithTallasCompanion d) {
    final map = <String, Variable>{};
    if (d.idProductoWithTalla.present) {
      map['id_producto_with_talla'] =
          Variable<int, IntType>(d.idProductoWithTalla.value);
    }
    if (d.producto.present) {
      map['producto'] = Variable<int, IntType>(d.producto.value);
    }
    if (d.talla.present) {
      map['talla'] = Variable<int, IntType>(d.talla.value);
    }
    return map;
  }

  @override
  $ProductosWithTallasTable createAlias(String alias) {
    return $ProductosWithTallasTable(_db, alias);
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
  $ProductosWithTallasTable _productosWithTallas;
  $ProductosWithTallasTable get productosWithTallas =>
      _productosWithTallas ??= $ProductosWithTallasTable(this);
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
  ProductosWithTallasDao _productosWithTallasDao;
  ProductosWithTallasDao get productosWithTallasDao =>
      _productosWithTallasDao ??= ProductosWithTallasDao(this as AppDatabase);
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
        productosWithTallas
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
  $CategoriesTable get categories => db.categories;
  $ColoresTable get colores => db.colores;
  $ProveedoresTable get proveedores => db.proveedores;
  $ProductosWithColoresTable get productosWithColores =>
      db.productosWithColores;
  $ProductosWithTallasTable get productosWithTallas => db.productosWithTallas;
  $TallasTable get tallas => db.tallas;
  AllProductsResult _rowToAllProductsResult(QueryRow row) {
    return AllProductsResult(
      idProducto: row.readInt('id_producto'),
      codigo: row.readString('codigo'),
      descripcion: row.readString('descripcion'),
      precioUnitario: row.readDouble('precio_unitario'),
      precioDocena: row.readDouble('precio_docena'),
      precioMayorista: row.readDouble('precio_mayorista'),
      precioYarda: row.readDouble('precio_yarda'),
      precioCien: row.readDouble('precio_cien'),
      precio500U: row.readDouble('precio500_u'),
      precioCaja: row.readDouble('precio_caja'),
      precioFardo: row.readDouble('precio_fardo'),
      precioRollo: row.readDouble('precio_rollo'),
      providerId: row.readInt('provider_id'),
      categoryId: row.readInt('category_id'),
      specifications: row.readString('specifications'),
      idProductoWithColor: row.readInt('id_producto_with_color'),
      producto: row.readInt('producto'),
      color: row.readInt('color'),
      idColor: row.readInt('id_color'),
      name: row.readString('name'),
      value: row.readString('value'),
      idProductoWithTalla: row.readInt('id_producto_with_talla'),
      producto1: row.readInt('producto'),
      talla: row.readInt('talla'),
      idTalla: row.readInt('id_talla'),
      size: row.readString('size'),
    );
  }

  Selectable<AllProductsResult> allProductsQuery(int idc) {
    return customSelectQuery(
        'SELECT * FROM productos INNER JOIN productos_with_colores ON productos_with_colores.producto = productos.id_producto INNER JOIN colores ON colores.id_color = productos_with_colores.color INNER JOIN productos_with_tallas ON productos_with_tallas.producto = productos.id_producto INNER JOIN tallas ON tallas.id_talla = productos_with_tallas.talla WHERE productos.category_id = :idc GROUP BY productos.descripcion',
        variables: [
          Variable.withInt(idc)
        ],
        readsFrom: {
          productos,
          productosWithColores,
          colores,
          productosWithTallas,
          tallas
        }).map(_rowToAllProductsResult);
  }

  Future<List<AllProductsResult>> allProducts(int idc) {
    return allProductsQuery(idc).get();
  }

  Stream<List<AllProductsResult>> watchAllProducts(int idc) {
    return allProductsQuery(idc).watch();
  }
}

class AllProductsResult {
  final int idProducto;
  final String codigo;
  final String descripcion;
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
  final int idProductoWithColor;
  final int producto;
  final int color;
  final int idColor;
  final String name;
  final String value;
  final int idProductoWithTalla;
  final int producto1;
  final int talla;
  final int idTalla;
  final String size;
  AllProductsResult({
    this.idProducto,
    this.codigo,
    this.descripcion,
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
    this.specifications,
    this.idProductoWithColor,
    this.producto,
    this.color,
    this.idColor,
    this.name,
    this.value,
    this.idProductoWithTalla,
    this.producto1,
    this.talla,
    this.idTalla,
    this.size,
  });
}

mixin _$ProductosWithColoresDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductosWithColoresTable get productosWithColores =>
      db.productosWithColores;
}
mixin _$ProductosWithTallasDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductosWithTallasTable get productosWithTallas => db.productosWithTallas;
}
