import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';


part 'database.g.dart'; 


class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get imageurl => text().withLength(min: 1, max: 1000)();
}

class Colores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get value => text().withLength(min: 1, max: 100)();
}

class Tallas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get size => text().withLength(min: 1, max: 100)();
}



@UseMoor(tables: [Categories, Colores, Tallas], daos: [CategoriesDao, ColoresDao, TallasDao])
class AppDatabase extends _$AppDatabase {
    AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: false));

    @override
    int get schemaVersion => 1;

}

@UseDao(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  final AppDatabase db;

  CategoriesDao(this.db) : super(db);

  Future<List<Categorie>> getAllCategories() => select(categories).get();
  Stream<List<Categorie>> watchAllCategories() => select(categories).watch();
  Future insertCategory(Insertable<Categorie> category) => into(categories).insert(category, orReplace: true);
  Future updateCategory(Insertable<Categorie> category) => update(categories).replace(category); 
  Future deleteCategory(Insertable<Categorie> category) => delete(categories).delete(category);
  Future truncateCategories() => delete(categories).go();
}

@UseDao(tables: [Colores])
class ColoresDao extends DatabaseAccessor<AppDatabase> with _$ColoresDaoMixin {
  final AppDatabase db;

  ColoresDao(this.db) : super(db);

  Future<List<Colore>> getAllColores() => select(colores).get();
  Stream<List<Colore>> watchAllColores() => select(colores).watch();
  Future insertColor(Insertable<Colore> color) => into(colores).insert(color);
   Future updateColor(Insertable<Colore> color) => update(colores).replace(color);
    Future deleteColor(Insertable<Colore> color) => delete(colores).delete(color);
    Future truncateColores() => delete(colores).go();
   
}

@UseDao(tables: [Tallas])
class TallasDao extends DatabaseAccessor<AppDatabase> with _$TallasDaoMixin {
  final AppDatabase db;

  TallasDao(this.db) : super(db);

  Future<List<Talla>> getAllTallas() => select(tallas).get();
  Stream<List<Talla>> watchAllTallas() => select(tallas).watch();
  Future insertTalla(Insertable<Talla> talla) => into(tallas).insert(talla, orReplace: true);
  Future updateTalla(Insertable<Talla> talla) => update(tallas).replace(talla); 
  Future deleteTalla(Insertable<Talla> talla) => delete(tallas).delete(talla);
  Future truncateTallas() => delete(tallas).go();
}
