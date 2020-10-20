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
      //print(res.body);
      if(res.statusCode == 200){
        List data = json.decode(res.body);
        //db.productosWithColoresDao.truncateProductosWithColores();
        //db.productosWithTallasDao.truncateProductosWithTallas();
        //db.tallasDao.truncateTallas();
        //db.coloresDao.truncateColores();
       //db.productosDao.truncateProducto();
        data.forEach((element) async {
          var producto = Producto(
            idProducto: element['id'], 
            codigo: element['codigo'],
            existencia: element['existencia'],
            descripcion: (element['descripcion'] != null) ? element['descripcion'] : 'No disponible', 
            specifications: (element['specification'] != null) ? element['specification'] : 'No especificada',
            providerId: element['provider']['id'],
            categoryId: element['category']['id'],
          );

           await db.productosDao.insertProducto(ProductosCompanion(
            categoryId: moor.Value(producto.categoryId),
            descripcion: moor.Value(producto.descripcion),
            idProducto: moor.Value(producto.idProducto),
            codigo: moor.Value(producto.codigo),
            existencia: moor.Value(producto.existencia),
            providerId: moor.Value(producto.providerId),
            specifications: moor.Value(producto.specifications),
          ));


          List auxColores = element['colors'];

         if(auxColores.length > 0){
            List<Colore> colores = auxColores.map((color) => Colore(idColor: color['id'], name: color['name'], value: color['value'])).toList();
          
          colores.forEach((c) async {
            await db.coloresDao.insertColor(ColoresCompanion(idColor: moor.Value(c.idColor), name: moor.Value(c.name), value: moor.Value(c.value)));
           });
         }

          List auxTallas = element['sizes'];

         if(auxTallas.length > 0){
            List<Talla> tallas = auxTallas.map((talla) => Talla(idTalla: talla['id'], size: talla['size'])).toList();
          
          tallas.forEach((t) async {
            await db.tallasDao.insertTalla(TallasCompanion(idTalla: moor.Value(t.idTalla), size: moor.Value(t.size)));
           });
         }

          await db.proveedoresDao.insertProveedor(ProveedoresCompanion(
             idProveedor: moor.Value(element['provider']['id']),
             email: moor.Value(element['provider']['email'] ?? 'no especificado'),
             name: moor.Value(element['provider']['name'] ?? 'No especificado'),
             phone: moor.Value(element['provider']['phone'] ?? '22577777'),
           ));


           List productoColors = element['producto_colors'];

           if(productoColors.length > 0){
             List<ProductosWithColore> pwcs = productoColors.map((e) => ProductosWithColore(idProductoWithColor: e['id'], producto: e['product_id'], color: e['color_id'])).toList();

             pwcs.forEach((pwc) async {
               ProductosWithColoresCompanion p = ProductosWithColoresCompanion(
                 idProductoWithColor: moor.Value(pwc.idProductoWithColor),
                 producto: moor.Value(pwc.producto),
                 color: moor.Value(pwc.color)
               ); 
               await db.productosWithColoresDao.insertProductoWithColores(p);
              });
           }

            List productoTallas = element['producto_sizes'];

          if(productoTallas.length > 0){
             List<ProductosWithTalla> pws = productoTallas.map((e) => ProductosWithTalla(idProductoWithTalla: e['id'], producto: e['product_id'], talla: e['size_id'])).toList();

             pws.forEach((ps) async {
               ProductosWithTallasCompanion p = ProductosWithTallasCompanion(
                 idProductoWithTalla: moor.Value(ps.idProductoWithTalla),
                 producto: moor.Value(ps.producto),
                 talla: moor.Value(ps.talla)
               ); 
               await db.productosWithTallasDao.insertProductoWithTallas(p);
              });
           }


            List productDetalles = element['product_details'];

           if(productDetalles.length > 0){
             List<ProductoDetalle> pds = productDetalles.map((e) => ProductoDetalle(idProductoDetalle: e['id'],
              productId: e['product_id'],
              colorId: e['color_id'],
              tallaId: e['size_id'],
              precioUnitario: (e['precioUnitario'] != null) ? double.parse(e['precioUnitario']) : 0.00,
              precioDocena: (e['precioDocena'] != null) ? double.parse(e['precioDocena']) : 0.00,
              precio500U: (e['precio500U'] != null) ? double.parse(e['precio500U']) : 0.00,
            precioMayorista: (e['precioMayorista'] != null) ? double.parse(e['precioMayorista']) : 0.00,
            precioCaja: (e['precioCaja'] != null) ? double.parse(e['precioCaja']) : 0.00,
            precioCien: (e['precioCien'] != null) ? double.parse(e['precioCien']) : 0.00,
            precioFardo: (e['precioFardo'] != null) ? double.parse(e['precioFardo']) : 0.00,
            precioRollo: (e['precioRollo'] != null) ? double.parse(e['precioRollo']) : 0.00,
            precioYarda: (e['precioYarda'] != null) ? double.parse(e['precioYarda']) : 0.00,
            precioBolsa: (e['precioBolsa'] != null) ? double.parse(e['precioBolsa']) : 0.00,
            precioGruesa: (e['precioGruesa'] != null) ? double.parse(e['precioGruesa']) : 0.00,
            precioMillar: (e['precioMillar'] != null) ? double.parse(e['precioMillar']) : 0.00,
             )).toList();

             pds.forEach((pd) async {
               ProductoDetallesCompanion p = ProductoDetallesCompanion(
                 idProductoDetalle: moor.Value(pd.idProductoDetalle),
                 productId: moor.Value(pd.productId),
                 colorId: moor.Value(pd.colorId),
                 tallaId: moor.Value(pd.tallaId),
                 precioUnitario: moor.Value(pd.precioUnitario),
                 precioDocena: moor.Value(pd.precioDocena),
                 precioMayorista: moor.Value(pd.precioMayorista),
                 precioYarda: moor.Value(pd.precioYarda),
                 precioCien: moor.Value(pd.precioCien),
                 precio500U: moor.Value(pd.precio500U),
                 precioCaja: moor.Value(pd.precioCaja),
                 precioFardo: moor.Value(pd.precioFardo),
                 precioRollo: moor.Value(pd.precioRollo),
                 precioGruesa: moor.Value(pd.precioGruesa),
                 precioMillar: moor.Value(pd.precioMillar),
                 precioBolsa: moor.Value(pd.precioBolsa),
               ); 
               await db.productoDetallesDao.insertProductoDetalle(p);
              });
           }
          
        });
      } else{

      }
    //_fetchCategoriesDB(_categorias);
    //return _categorias;
    } catch (e) {
      //print(e.toString());
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

  Future<List<Producto>> getAllProducts(int idCategoria) async {
    final _url = Uri.https(_urlBase, 'api/v1/categories/$idCategoria/products.json');
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


  Future<bool> updateProduct(Producto p) async {
    final _url = Uri.https(_urlBase, 'api/v1/categories/${p.categoryId}/products/${p.idProducto}.json',{
      'product[codigo]': p.codigo,
      'product[descripcion]': p.descripcion,
      'product[existencia]': p.existencia.toString(),
      'product[specification]': p.specifications,
    });
    try {
      final res = await http.patch(_url);
      if(res.statusCode == 200){
       final decodedData = json.decode(res.body);
       await db.productosDao.updateProducto(
         ProductosCompanion(
           idProducto: moor.Value(decodedData['id']),
           codigo: moor.Value(decodedData['codigo']),
           descripcion: moor.Value(decodedData['descripcion']),
           existencia: moor.Value(decodedData['existencia']),
           specifications: moor.Value(decodedData['specification']),
           categoryId: moor.Value(decodedData['category']['id']),
           providerId: moor.Value(decodedData['provider']['id'])
         )
       );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

 

}