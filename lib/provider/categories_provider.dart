import 'dart:convert';


import 'package:demo/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart' as moor;


import 'dart:async';



class CategoriesProvider with ChangeNotifier {
    CategoriesDao _categoriesDao;
    final _urlBase = 'pinto-business.herokuapp.com';
    Future<List<Categorie>> _categoriesFuture;

  CategoriesProvider(this._categoriesDao) {
  }

  void requestCategories() {
    this._categoriesFuture = getCategories();
    notifyListeners();
  }

  Future<List<Categorie>> get categories => this._categoriesFuture;

  Future<List<Categorie>> getCategories() async {
    final _url = Uri.https(_urlBase, 'api/v1/categories.json');
    List<Categorie> _categorias = new List<Categorie>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
       _categorias = new List<Categorie>();
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          final Categorie c = new Categorie(
            id: element['id'],
            name: element['name'],
            imageurl: element['image_url']
          );
          _categorias.add(c);
        });
    }
    print('awebo');
    _fetchCategoriesDB(_categorias);
    return _categorias;
    } catch (e) {
      return _categorias;
    }
  }

   void _fetchCategoriesDB(List<Categorie> catList) {
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
  }

}