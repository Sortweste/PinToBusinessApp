import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';


import 'dtos/producto_con_colores.dart';
import 'dtos/producto_con_colores_y_tallas.dart';

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

class Proveedores extends Table {
   IntColumn get id => integer().autoIncrement()();
   TextColumn get name => text().withLength(min: 1, max: 100)();
   TextColumn get phone => text().nullable()();
   TextColumn get email => text().nullable()();
}

class Productos extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get codigo => text().withLength(min: 1, max: 100)();
  RealColumn get precioUnitario => real().nullable()();
  RealColumn get precioDocena => real().nullable()();
  RealColumn get precioMayorista => real().nullable()();
  RealColumn get precioYarda => real().nullable()();
  RealColumn get precioCien => real().nullable()();
  RealColumn get precio500U => real().nullable()();
  RealColumn get precioCaja => real().nullable()();
  RealColumn get precioFardo => real().nullable()();
  RealColumn get precioRollo => real().nullable()();
  IntColumn get providerId => integer().nullable().customConstraint('NULL REFERENCES proveedores(id)')();
  IntColumn get categoryId => integer().nullable().customConstraint('NULL REFERENCES categories(id)')();
  TextColumn get specifications => text().withLength(min: 1, max: 100)();
}

class ProductosWithColores extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get producto => integer()();
  IntColumn get color => integer()();
}

class ProductosConColoresWithTallas extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoConColores => integer()();
  IntColumn get tallas => integer()();
}

@UseMoor(tables: [Categories, Colores, Proveedores, Tallas, Productos, ProductosWithColores, ProductosConColoresWithTallas], daos: [CategoriesDao, ColoresDao, TallasDao, ProveedoresDao, ProductosDao, ProductosWithColoresDao, ProductosConColoresWithTallasDao])
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
  Future insertProveedor(Insertable<Proveedore> proveedore) => into(proveedores).insert(proveedore);
  Future updateProveedor(Insertable<Proveedore> proveedore) => update(proveedores).replace(proveedore);
  Future deleteProveedor(Insertable<Proveedore> proveedore) => delete(proveedores).delete(proveedore);
  Future truncateProveedor() => delete(proveedores).go();
}

@UseDao(tables: [Productos])
class ProductosDao extends DatabaseAccessor<AppDatabase> with _$ProductosDaoMixin {
  final AppDatabase db;

  ProductosDao(this.db) : super(db);

  Future<List<Producto>> getAllProducto() => select(productos).get();
  Stream<List<Producto>> watchAllProducto() => select(productos).watch();
  //Future insertProducto(Insertable<Producto> producto) => into(productos).insert(producto);
  Future updateProducto(Insertable<Producto> producto) => update(productos).replace(producto);
  Future deleteProducto(Insertable<Producto> producto) => delete(productos).delete(producto);
  Future truncateProducto() => delete(productos).go();
   
}

@UseDao(tables: [ProductosWithColores, Productos, Colores])
class ProductosWithColoresDao extends DatabaseAccessor<AppDatabase> with _$ProductosWithColoresDaoMixin {
  final AppDatabase db;

  ProductosWithColoresDao(this.db) : super(db);
  
    Future<void> insertProductosWithColore(ProductoConColores entry){
    return transaction( () async {
        
        final producto = entry.producto;
        await into(productos).insert(producto, mode: InsertMode.replace);

        await ( 
          (delete(productosWithColores))
            ..where( (entry) => entry.producto.equals(producto.id) )  
        ).go();
        
        for(final color in entry.colores){
          await into(productosWithColores).insert(ProductosWithColoresCompanion(
            producto: Value(producto.id),
            color: Value(color.id)));
        }
    });
  }

  Stream<ProductoConColores> watchProductoConColores(int id){
    final productQuery = (select(productos))..where( (producto) => producto.id.equals(id) );
    
    final coloresQuery = select(productosWithColores).join([
      innerJoin(colores, colores.id.equalsExp(productosWithColores.color))
    ])..where(productosWithColores.producto.equals(id));

    final productStream = productQuery.watchSingle();
    final coloresStream = coloresQuery.watch().map( (rows) {
      return rows.map( (row) => row.readTable(colores)).toList();
    }); 

    return Rx.combineLatest2(productStream, coloresStream, (Producto p, List<Colore> colores){
      return ProductoConColores(producto: p, colores: colores);
    });
  }  
  
}

@UseDao(tables: [ProductosWithColores, ProductosConColoresWithTallas, Tallas])
class ProductosConColoresWithTallasDao extends DatabaseAccessor<AppDatabase> with _$ProductosConColoresWithTallasDaoMixin {
  final AppDatabase db;

  ProductosConColoresWithTallasDao(this.db) : super(db);

  Future<void> insertProductosConColoresWithTalla(ProductoConColoresYTallas entry){
    return transaction( () async {
        
        final productosWithColore = entry.productoConColores;
        await into(productosWithColores).insert(productosWithColore, mode: InsertMode.replace);

        await ( 
          (delete(productosConColoresWithTallas))
            ..where( (entry) => entry.productoConColores.equals(productosWithColore.id) )
        ).go();
        
        
        for(final talla in entry.tallas){
          await into(productosConColoresWithTallas).insert(
            ProductosConColoresWithTallasCompanion(
            productoConColores: Value(productosWithColore.id),
            tallas: Value(talla.id))
          );
        }

    });
  }

  Stream<ProductoConColoresYTallas> watchProductoConColoresYTallas(int id){
    final productWithColorQuery = (select(productosWithColores))..where( (productosWithColore) => productosWithColore.id.equals(id) );
    
    final tallasQuery = select(productosConColoresWithTallas).join([
      innerJoin(tallas, tallas.id.equalsExp(productosConColoresWithTallas.tallas))
    ])..where(productosConColoresWithTallas.productoConColores.equals(id));

    final productWithColorStream = productWithColorQuery.watchSingle();
    final tallasStream = tallasQuery.watch().map( (rows) {
      return rows.map( (row) => row.readTable(tallas)).toList();
    }); 

    return Rx.combineLatest2(productWithColorStream, tallasStream, (ProductosWithColore p, List<Talla> tallas){
      return ProductoConColoresYTallas(productoConColores: p, tallas: tallas);
    });
  }

  Stream<List<ProductoConColoresYTallas>> watchAllProductoConColoresYTallas(){
      final productsWithColorStream = select(productosWithColores).watch();

      return productsWithColorStream.switchMap( (productosWithColore){
        final idToProductosWithColore = { for(var producto in productosWithColore) producto.id: producto };
        final ids = idToProductosWithColore.keys;

        final entryQuery = select(productosConColoresWithTallas).join([
          innerJoin(tallas, tallas.id.equalsExp(productosConColoresWithTallas.tallas))
        ])..where(productosConColoresWithTallas.productoConColores.isIn(ids));

        return entryQuery.watch().map((rows){

          final idToTallas = <int, List<Talla>>{};
          for(var row in rows){
            final item = row.readTable(tallas);
            final id = row.readTable(productosConColoresWithTallas).productoConColores;
            idToTallas.putIfAbsent(id, ()=>[]).add(item);
          }

          return [
            for(var id in ids)
              ProductoConColoresYTallas(productoConColores: idToProductosWithColore[id], tallas: idToTallas[id] ?? []),
          ];
        });
      });
  }

}
