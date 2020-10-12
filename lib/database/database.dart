import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';
/*

import 'dtos/producto_con_colores.dart';
import 'dtos/producto_con_colores_y_tallas.dart';*/

import 'dtos/product_with_colors_and_sizes.dart';

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
  IntColumn get existencia => integer().nullable()();
}


class ProductosWithColores extends Table{
  IntColumn get idProductoWithColor => integer().autoIncrement()();
  IntColumn get producto => integer().customConstraint('NULL REFERENCES productos(id_producto)')();
  IntColumn get color => integer().customConstraint('NULL REFERENCES colores(id_color)')();
}

class ProductosWithTallas extends Table{
  IntColumn get idProductoWithTalla => integer().autoIncrement()();
  IntColumn get producto => integer().customConstraint('NULL REFERENCES productos(id_producto)')();
  IntColumn get talla => integer().customConstraint('NULL REFERENCES tallas(id_talla)')();
}

@UseMoor(tables: [Categories, Colores, Proveedores, Tallas, Productos, ProductosWithColores, ProductosWithTallas], daos: [CategoriesDao, ColoresDao, TallasDao, ProveedoresDao, ProductosDao, ProductosWithColoresDao, ProductosWithTallasDao])
class AppDatabase extends _$AppDatabase {
    AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'data.sqlite', logStatements: false));

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

@UseDao(tables: [Colores, ProductosWithColores],
queries: {
   'allProductColors': 'SELECT * FROM colores INNER JOIN productos_with_colores ON productos_with_colores.color = colores.id_color AND productos_with_colores.producto = :idc',
}
)
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

@UseDao(tables: [Tallas, ProductosWithTallas], 
queries: {
  'allProductSizes': 'SELECT * FROM tallas INNER JOIN productos_with_tallas ON productos_with_tallas.talla = tallas.id_talla AND productos_with_tallas.producto = :idc',
}
)
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
     'productColors': 'SELECT * FROM colores INNER JOIN productos_with_colores ON productos_with_colores.color = colores.id_color AND productos_with_colores.producto = :idc',
      'productSizes': 'SELECT * FROM tallas INNER JOIN productos_with_tallas ON productos_with_tallas.talla = tallas.id_talla AND productos_with_tallas.producto = :idc',
    'singleProduct': 'SELECT * FROM productos WHERE productos.category_id = :idc',
     'findProduct': 'SELECT * FROM productos WHERE productos.id_producto = :idc',
     'productProveedor': 'SELECT * FROM proveedores WHERE proveedores.id_proveedor = :id'
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

  Stream<List<ProductWithColorsAndSizes>> watchProductoWithColorsAndSizes(int id){
    /*final SimpleSelectStatement<Colores, Colore> colorsQuery =
      select(colores)
        ..join(<Join<Table, DataClass>>[
          innerJoin(
            productosWithColores,
            productosWithColores.color.equalsExp(colores.idColor) &
            productosWithColores.producto.equals(id),
          ),
        ]);*/
        

       /* final SimpleSelectStatement<Tallas, Talla> tallasQuery =
      select(tallas)
        ..join(<Join<Table, DataClass>>[
          innerJoin(
            productosWithTallas,
            productosWithTallas.talla.equalsExp(tallas.idTalla) &
            productosWithTallas.producto.equals(id),
          ),
        ]);*/

        final SimpleSelectStatement<Productos, Producto> productoQuery =
      select(productos)..where((tbl) => tbl.idProducto.equals(id));

      
      return Rx.combineLatest3(
        watchProductColors(id),
        watchProductSizes(id),
        productoQuery.watch(), 
        (List<ProductColorsResult> coloresQ,List<ProductSizesResult> tallasQ, List<Producto> productoQ) {
          return productoQ.map((e) => 
            ProductWithColorsAndSizes(
                producto: productoQ[0],
                talla: tallasQ,
                colore: coloresQ,
            )
          ).toList();
        }
      );

  }
 /* Future<ProductWithColorsAndSizes> loadProductWithColorAndSizes(int id) async {

    final rows = await select(productos).join([
      innerJoin(productosWithColores, productosWithColores.color.equalsExp(colores.idColor) & productosWithColores.producto.equals(id)),
      innerJoin(productosWithTallas, productosWithTallas.talla.equalsExp(tallas.idTalla) & productosWithTallas.producto.equals(id)),
    ]).get();

    return rows.map((resultRow){
      print(resultRow);
      
      /*return ProductWithColorsAndSizes(
        producto: resultRow. (productos),
        colore: resultRow.data(colores),
        talla: resultRow.data(tallas), 
      );*/
    }).toList()[0];
  }*/
}

/*Stream<List<ProductWithColorsAndSizes>> loadProductWithColorAndSizes(int id){
  final query = 'SELECT * FROM productos INNER JOIN productos_with_colores ON productos_with_colores.producto = productos.id_producto INNER JOIN colores ON colores.id_color = productos_with_colores.color INNER JOIN productos_with_tallas ON productos_with_tallas.producto = productos.id_producto INNER JOIN tallas ON tallas.id_talla = productos_with_tallas.talla WHERE productos.id_producto = $id;';
  return customSelectQuery(query).watch().map();
  return customSelectQuery(
    query,
    variables: [],
    readsFrom: {productos, tallas, colores, productosWithColores, productosWithTallas},
  ).watch().map((rows){
    print(rows);
    return rows
    .map((row) => ProductWithColorsAndSizes(
        producto: row.readTable(Productos),
        colore: row.readTable(Colores),
        talla: row.readTable(Tallas), 
      )).toList(); 
  });
}*/



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
