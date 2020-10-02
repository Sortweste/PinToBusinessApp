import 'dart:convert';


import 'package:demo/database/database.dart';
import 'package:demo/database/dtos/producto_con_colores.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart' as moor;


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
    final _url = Uri.https(_urlBase, 'api/v1/categories/${idCategoria}/products.json');
   // List<Categorie> _categorias = new List<Categorie>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
        List data = json.decode(res.body); 
        data.forEach((element) {
          var producto = Producto(
            id: element['id'], 
            codigo: element['codigo'], 
            specifications: element['specification'], 
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

          List<Colore> colores = auxColores.map((color) => Colore(id: color['id'], name: color['name'], value: color['value'])).toList();
          
          ProductoConColores productoConColores = ProductoConColores(colores: colores, producto: producto);

          db.productosWithColoresDao.insertProductosWithColore(productoConColores);

        });
        
      } else{

      }
    //_fetchCategoriesDB(_categorias);
    //return _categorias;
    } catch (e) {
     // return _categorias;
    }
  }



  /* void _fetchCategoriesDB(List<Categorie> catList) {
    if(catList.isNotEmpty){
      catList.forEach((element) {
       final categoria = CategoriesCompanion(
         id: moor.Value(element.id),
         name: moor.Value(element.name),
         imageurl: moor.Value(element.imageurl)
       );
      _categoriesDao.insertCategory(categoria);
     });
    }
  }*/

}