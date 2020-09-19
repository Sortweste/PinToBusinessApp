import 'dart:convert';
import 'dart:math';

import 'package:demo/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:provider/provider.dart';


class CategoriesProvider with ChangeNotifier {

  final _urlBase = 'pinto-business.herokuapp.com';

  

  Future<List<Categorie>> getCategories() async {
    final _url = Uri.https(_urlBase, 'api/v1/categories.json');
    final List<Categorie> categorias = new List<Categorie>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          categorias.add(Categorie.fromJson(element));
        });
    }
    print('awebo');
    return categorias;
    } catch (e) {
      return categorias;
    }
  }

}