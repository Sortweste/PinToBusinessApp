import 'dart:convert';


import 'package:demo/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:flutter/material.dart';

import 'dart:async';

class ProductsProvider with ChangeNotifier {
    final _urlBase = 'pinto-business.herokuapp.com';
    final AppDatabase db;
    //Future<List<ProductoConColoresYTallas>> _productsFuture;

  ProductsProvider(this.db);

 /* void requestCategories() {
    this._categoriesFuture = getCategories();
    notifyListeners();
  }*/

 // Future<List<Categorie>> get categories => this._categoriesFuture;

  Future getProductos(int idCategoria) async {
    final _url = Uri.https(_urlBase, 'api/v1/categories/$idCategoria/products.json');
    try {
      final res = await http.get(_url);
      print(res.body);
      if(res.statusCode == 200){
        List data = json.decode(res.body);
        db.productosWithColoresDao.truncateProductosWithColores();
        data.forEach((element) async {
          print(element);
          var producto = Producto(
            idProducto: element['id'], 
            codigo: element['codigo'],
            existencia: element['existencia'],
            descripcion: (element['descripcion'] != null) ? element['descripcion'] : 'No disponible', 
            specifications: (element['specification'] != null) ? element['specification'] : 'No especificada', 
            categoryId: element['category']['id'],
            precio500U: (element['precio500U'] != null) ? double.parse(element['precio500U']) : 0.00,
            precioMayorista: (element['precioMayorista'] != null) ? double.parse(element['precioMayorista']) : 0.00,
            precioCaja: (element['precioCaja'] != null) ? double.parse(element['precioCaja']) : 0.00,
            precioCien: (element['precioCien'] != null) ? double.parse(element['precioCien']) : 0.00,
            precioDocena: (element['precioDocena'] != null) ? double.parse(element['precioDocena']) : 0.00,
            precioFardo: (element['precioFardo'] != null) ? double.parse(element['precioFardo']) : 0.00,
            precioRollo: (element['precioRollo'] != null) ? double.parse(element['precioRollo']) : 0.00,
            precioUnitario: (element['precioUnitario'] != null) ? double.parse(element['precioUnitario']) : 0.00,
            precioYarda: (element['precioYarda'] != null) ? double.parse(element['precioYarda']) : 0.00,
            providerId: element['provider']['id'],
          );

          List auxColores = element['colors'];
          auxColores.removeWhere((value) => value == null);

          List<Colore> colores = auxColores.map((color) => Colore(idColor: color['id'], name: color['name'], value: color['value'])).toList();
          
          await db.productosWithColoresDao.truncateProductosWithColores();
          colores.forEach((c) async {
            await db.coloresDao.insertColor(ColoresCompanion(idColor: moor.Value(c.idColor), name: moor.Value(c.name), value: moor.Value(c.value)));
            var pwc = ProductosWithColoresCompanion(color: moor.Value(c.idColor), producto: moor.Value(producto.idProducto));
            await db.productosWithColoresDao.insertProductoWithColores(pwc);
           });

          List auxTallas = element['sizes'];
          auxTallas.removeWhere((value) => value == null);

          List<Talla> tallas = auxTallas.map((talla) => Talla(idTalla: talla['id'], size: talla['size'])).toList();
          
          await  db.tallasDao.truncateTallas();
          tallas.forEach((t) async {
            await db.tallasDao.insertTalla(TallasCompanion(idTalla: moor.Value(t.idTalla), size: moor.Value(t.size)));
            var pwt = ProductosWithTallasCompanion(talla: moor.Value(t.idTalla),producto: moor.Value(producto.idProducto));
            await db.productosWithTallasDao.insertProductoWithTallas(pwt);
           });

          await db.proveedoresDao.insertProveedor(ProveedoresCompanion(
             idProveedor: moor.Value(element['provider']['id']),
             email: moor.Value(element['provider']['email']),
             name: moor.Value(element['provider']['name']),
             phone: moor.Value(element['provider']['phone']),
           ));
          
          await db.productosDao.insertProducto(ProductosCompanion(
            categoryId: moor.Value(producto.categoryId),
            descripcion: moor.Value(producto.descripcion),
            idProducto: moor.Value(producto.idProducto),
            codigo: moor.Value(producto.codigo),
            existencia: moor.Value(producto.existencia),
            precio500U: moor.Value(producto.precio500U),
            precioCaja: moor.Value(producto.precioCaja),
            precioCien: moor.Value(producto.precioCien),
            precioDocena: moor.Value(producto.precioDocena),
            precioFardo: moor.Value(producto.precioFardo),
            precioMayorista: moor.Value(producto.precioMayorista),
            precioRollo: moor.Value(producto.precioRollo),
            precioUnitario: moor.Value(producto.precioUnitario),
            precioYarda: moor.Value(producto.precioYarda),
            providerId: moor.Value(producto.providerId),
            specifications: moor.Value(producto.specifications),
          ));
        });
        //print(res.body);
      } else{

      }
    //_fetchCategoriesDB(_categorias);
    //return _categorias;
    } catch (e) {
      print(e.toString());
     // return _categorias;
    }
  }

  Future<List<Producto>> searhProducts(String query, int categoryId) async {
    final _url = Uri.https(_urlBase, 'api/v1/categories/$categoryId/products/search/$query.json');
    List<Producto> _productos = new List<Producto>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
       _productos = new List<Producto>();
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          final Producto p = new Producto(
            idProducto: element['id'], 
            codigo: element['codigo'],
            existencia: element['existencia'],
            descripcion: (element['descripcion'] != null) ? element['descripcion'] : 'No disponible', 
            specifications: (element['specification'] != null) ? element['specification'] : 'No especificada', 
            categoryId: element['category']['id'],
            precio500U: (element['precio500U'] != null) ? double.parse(element['precio500U']) : 0.00,
            precioMayorista: (element['precioMayorista'] != null) ? double.parse(element['precioMayorista']) : 0.00,
            precioCaja: (element['precioCaja'] != null) ? double.parse(element['precioCaja']) : 0.00,
            precioCien: (element['precioCien'] != null) ? double.parse(element['precioCien']) : 0.00,
            precioDocena: (element['precioDocena'] != null) ? double.parse(element['precioDocena']) : 0.00,
            precioFardo: (element['precioFardo'] != null) ? double.parse(element['precioFardo']) : 0.00,
            precioRollo: (element['precioRollo'] != null) ? double.parse(element['precioRollo']) : 0.00,
            precioUnitario: (element['precioUnitario'] != null) ? double.parse(element['precioUnitario']) : 0.00,
            precioYarda: (element['precioYarda'] != null) ? double.parse(element['precioYarda']) : 0.00,
            providerId: element['provider']['id'],
          );
          _productos.add(p);
        });
    }
    return _productos;
    } catch (e) {
      return _productos;
    }
  }

 

}