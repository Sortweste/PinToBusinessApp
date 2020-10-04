import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
/*import 'package:rxdart/rxdart.dart';


import 'dtos/producto_con_colores.dart';
import 'dtos/producto_con_colores_y_tallas.dart';*/

part 'database.g.dart'; 


class Categories extends Table {
  IntColumn get idCategory => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get imageurl => text().withLength(min: 1, max: 1000)();
}

class Colores extends Table {
  IntColumn get idColor => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get value => text().withLength(min: 1, max: 100)();
}

class Tallas extends Table {
  IntColumn get idTalla => integer().autoIncrement()();
  TextColumn get size => text().withLength(min: 1, max: 100)();
}

class Proveedores extends Table {
   IntColumn get idProveedor => integer().autoIncrement()();
   TextColumn get name => text().withLength(min: 1, max: 100)();
   TextColumn get phone => text().nullable()();
   TextColumn get email => text().nullable()();
}

class Productos extends Table{
  IntColumn get idProducto => integer().autoIncrement()();
  TextColumn get codigo => text().withLength(min: 1, max: 100)();
  TextColumn get descripcion => text().nullable()();
  RealColumn get precioUnitario => real().nullable()();
  RealColumn get precioDocena => real().nullable()();
  RealColumn get precioMayorista => real().nullable()();
  RealColumn get precioYarda => real().nullable()();
  RealColumn get precioCien => real().nullable()();
  RealColumn get precio500U => real().nullable()();
  RealColumn get precioCaja => real().nullable()();
  RealColumn get precioFardo => real().nullable()();
  RealColumn get precioRollo => real().nullable()();
  IntColumn get providerId => integer().nullable().customConstraint('NULL REFERENCES proveedores(id_proveedor)')();
  IntColumn get categoryId => integer().nullable().customConstraint('NULL REFERENCES categories(id_category)')();
  TextColumn get specifications => text().nullable()();
}


class ProductosWithColores extends Table{
  IntColumn get idProductoWithColor => integer().autoIncrement()();
  IntColumn get producto => integer()();
  IntColumn get color => integer()();
}

class ProductosWithTallas extends Table{
  IntColumn get idProductoWithTalla => integer().autoIncrement()();
  IntColumn get producto => integer()();
  IntColumn get talla => integer()();
}

@UseMoor(tables: [Categories, Colores, Proveedores, Tallas, Productos, ProductosWithColores, ProductosWithTallas], daos: [CategoriesDao, ColoresDao, TallasDao, ProveedoresDao, ProductosDao, ProductosWithColoresDao, ProductosWithTallasDao])
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
  Stream<List<Categorie>> watchAllCategories() => (select(categories)
    
  ).watch();
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
  Future insertColor(Insertable<Colore> color) => into(colores).insert(color, orReplace: true);
   Future updateColor(Insertable<Colore> color) => update(colores).replace(color);
    Future deleteColor(Insertable<Colore> color) => delete(colores).delete(color);
    Future truncateColores() => delete(colores).go();
   
}

@UseDao(tables: [Tallas])
class TallasDao extends DatabaseAccessor<AppDatabase> with _$TallasDaoMixin {
  final AppDatabase db;

  TallasDao(this.db) : super(db);

  Future<List<Talla>> getAllTallas() => select(tallas).get();
  Stream<List<Talla>> watchAllTallas() => (select(tallas))
   .watch();
  Future insertTalla(Insertable<Talla> talla) => into(tallas).insert(talla, orReplace: true);
  Future updateTalla(Insertable<Talla> talla) => update(tallas).replace(talla); 
  Future deleteTalla(Insertable<Talla> talla) => delete(tallas).delete(talla);
  Future truncateTallas() => delete(tallas).go();
}

@UseDao(tables: [Proveedores])
class ProveedoresDao extends DatabaseAccessor<AppDatabase> with _$ProveedoresDaoMixin {
  final AppDatabase db;

  ProveedoresDao(this.db) : super(db);

  Future<List<Proveedore>> getAllProveedores() => select(proveedores).get();
  Stream<List<Proveedore>> watchAllProveedores() => select(proveedores).watch();
  Future insertProveedor(Insertable<Proveedore> proveedore) => into(proveedores).insert(proveedore, orReplace: true);
  Future updateProveedor(Insertable<Proveedore> proveedore) => update(proveedores).replace(proveedore);
  Future deleteProveedor(Insertable<Proveedore> proveedore) => delete(proveedores).delete(proveedore);
  Future truncateProveedor() => delete(proveedores).go();
}

@UseDao(tables: [Productos, Categories, Colores, Proveedores, ProductosWithColores, ProductosWithTallas, Tallas],
  queries: {
    'allProducts': 'SELECT * FROM productos INNER JOIN productos_with_colores ON productos_with_colores.producto = productos.id_producto INNER JOIN colores ON colores.id_color = productos_with_colores.color INNER JOIN productos_with_tallas ON productos_with_tallas.producto = productos.id_producto INNER JOIN tallas ON tallas.id_talla = productos_with_tallas.talla WHERE productos.category_id = :idc GROUP BY productos.descripcion'
  }
)
class ProductosDao extends DatabaseAccessor<AppDatabase> with _$ProductosDaoMixin {
  final AppDatabase db;

  ProductosDao(this.db) : super(db);

  Future<List<Producto>> getAllProducto() => select(productos).get();
  Stream<List<Producto>> watchAllProducto() => select(productos).watch();
  Future insertProducto(Insertable<Producto> producto) => into(productos).insert(producto, orReplace: true);
  Future updateProducto(Insertable<Producto> producto) => update(productos).replace(producto);
  Future deleteProducto(Insertable<Producto> producto) => delete(productos).delete(producto);
  Future truncateProducto() => delete(productos).go();
}

@UseDao(tables: [ProductosWithColores])
class ProductosWithColoresDao extends DatabaseAccessor<AppDatabase> with _$ProductosWithColoresDaoMixin {
  final AppDatabase db;

  ProductosWithColoresDao(this.db) : super(db);

  Future<List<ProductosWithColore>> getAllProductosWithColores() => select(productosWithColores).get();
  Stream<List<ProductosWithColore>> watchAllProductosWithColores() => select(productosWithColores).watch();
  Future insertProductoWithColores(Insertable<ProductosWithColore> pwc) => into(productosWithColores).insert(pwc, orReplace: true);
  Future updateProductoWithColores(Insertable<ProductosWithColore> pwc) => update(productosWithColores).replace(pwc);
  Future deleteProducto(Insertable<ProductosWithColore> pwc) => delete(productosWithColores).delete(pwc);
  Future truncateProductosWithColores() => delete(productosWithColores).go();
}

@UseDao(tables: [ProductosWithTallas])
class ProductosWithTallasDao extends DatabaseAccessor<AppDatabase> with _$ProductosWithTallasDaoMixin {
  final AppDatabase db;

  ProductosWithTallasDao(this.db) : super(db);

  Future<List<ProductosWithTalla>> getAllProductosWithTallas() => select(productosWithTallas).get();
  Stream<List<ProductosWithTalla>> watchAllProductosWithTallas() => select(productosWithTallas).watch();
  Future insertProductoWithTallas(Insertable<ProductosWithTalla> pwt) => into(productosWithTallas).insert(pwt, orReplace: true);
  Future updateProductoWithTalla(Insertable<ProductosWithTalla> pwt) => update(productosWithTallas).replace(pwt);
  Future deleteProductoWithTalla(Insertable<ProductosWithTalla> pwt) => delete(productosWithTallas).delete(pwt);
  Future truncateProductosWithTallas() => delete(productosWithTallas).go();
}
