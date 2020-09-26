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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  $ColoresTable _colores;
  $ColoresTable get colores => _colores ??= $ColoresTable(this);
  $TallasTable _tallas;
  $TallasTable get tallas => _tallas ??= $TallasTable(this);
  CategoriesDao _categoriesDao;
  CategoriesDao get categoriesDao =>
      _categoriesDao ??= CategoriesDao(this as AppDatabase);
  ColoresDao _coloresDao;
  ColoresDao get coloresDao => _coloresDao ??= ColoresDao(this as AppDatabase);
  TallasDao _tallasDao;
  TallasDao get tallasDao => _tallasDao ??= TallasDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categories, colores, tallas];
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
