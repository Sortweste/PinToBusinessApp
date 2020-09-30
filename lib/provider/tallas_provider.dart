import 'dart:convert';


import 'package:demo/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart' as moor;


import 'dart:async';



class TallasProvider with ChangeNotifier {
    TallasDao _tallasDao;
    final _urlBase = 'pinto-business.herokuapp.com';
    Future<List<Talla>> _tallasFuture;

  TallasProvider(this._tallasDao);

  void requestTallas() {
    this._tallasFuture = getTallas();
    notifyListeners();
  }

  Future<List<Talla>> get tallas => this._tallasFuture;

  Future<List<Talla>> getTallas() async {
    final _url = Uri.https(_urlBase, 'api/v1/sizes.json');
    List<Talla> _tallas = new List<Talla>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
       _tallas = new List<Talla>();
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          final Talla t = new Talla(
            id: element['id'],
            size: element['size']
          );
          _tallas.add(t);
        });
    }
    print('awebo');
    _fetchTallasDB(_tallas);
    return _tallas;
    } catch (e) {
      return _tallas;
    }
  }

   void _fetchTallasDB(List<Talla> tList) {
    if(tList.isNotEmpty){
      tList.forEach((element) {
       final talla = TallasCompanion(
         id: moor.Value(element.id),
         size: moor.Value(element.size),
       );
      _tallasDao.insertTalla(talla);
     });
    }
  }

}