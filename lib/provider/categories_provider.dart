import 'dart:convert';

import 'package:demo/database/database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class CategoriesProvider {

  final _urlBase = 'pinto-business.herokuapp.com';

  CategoriesProvider(){

  }

  Future<List<Categorie>> getCategories() async {
    final _url = Uri.https(_urlBase, 'api/v1/categories.json');
    final res = await http.get(_url);
    final List<Categorie> categorias = new List<Categorie>();
    if(res.statusCode == 200){
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          categorias.add(Categorie.fromJson(element));
        });
    }
    return categorias;
  }


}