import 'dart:convert';

import 'package:demo/database/database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart' as moor;


import 'dart:async';


class ProveedorProvider with ChangeNotifier{
    AppDatabase _db;
    final _urlBase = 'pinto-business.herokuapp.com';

  ProveedorProvider(this._db);

  Future<bool> updateProveedor(Proveedore p) async {
    final _url = Uri.https(_urlBase, 'api/v1/providers/${p.idProveedor}.json',{
      'provider[name]': p.name,
      'provider[email]': p.email,
      'provider[phone]': p.phone
    });
    try {
      final res = await http.patch(_url);
      if(res.statusCode == 200){
       final decodedData = json.decode(res.body);
       await _db.proveedoresDao.updateProveedor(
         ProveedoresCompanion(
           idProveedor: moor.Value(decodedData['id']),
           name: moor.Value(decodedData['name']),
           phone: moor.Value(decodedData['phone']),
           email: moor.Value(decodedData['email'])
         )
       );
      }
      return true;
    } catch (e) {
      return false;
    }
  }



}