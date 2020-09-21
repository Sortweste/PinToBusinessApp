import 'dart:convert';
import 'dart:math';

import 'package:demo/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:provider/provider.dart';


class ColoresProvider with ChangeNotifier {

  final _urlBase = 'pinto-business.herokuapp.com';

  Future<List<Colore>> getColores() async {
    final _url = Uri.https(_urlBase, 'api/v1/colors.json');
    final List<Colore> colores = new List<Colore>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          colores.add(Colore.fromJson(element));
        });
    }
    return colores;
    } catch (e) {
      return colores;
    }
  }

}