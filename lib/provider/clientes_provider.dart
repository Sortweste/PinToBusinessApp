import 'dart:convert';


import 'package:demo/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart' as moor;


import 'dart:async';



class ClientesProvider {
    AppDatabase _db;
    final _urlBase = 'pinto-business.herokuapp.com';

  ClientesProvider(this._db);


Future<List<Cliente>> getClientes() async {
    final _url = Uri.https(_urlBase, 'api/v1/clients');
    List<Cliente> _clientes = new List();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
        print(res.body);
        await _db.clientesDao.truncateClientes();
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          final Cliente c = new Cliente(
            idCliente: element['id'],
            nombre: element['nombre'],
            apellido: element['apellido'],
            telefono: element['telefono'],
            email: element['email'],
            vigente: false
          );
          _clientes.add(c);
        });
    }
    _fetchClientesDB(_clientes);
    return _clientes;
    } catch (e) {
      return _clientes;
    }
  }

  Future<bool> deletCliente(Cliente c) async {
    final _url = Uri.https(_urlBase, 'api/v1/clients/${c.idCliente.toString()}');
    try {
      final res = await http.delete(_url);
      print(res.statusCode);
      print(res.body);
      if(res.statusCode == 204){
       await _db.clientesDao.deleteCliente(
         ClientesCompanion(
           idCliente: moor.Value(c.idCliente),
           nombre: moor.Value(c.nombre),
           apellido: moor.Value(c.apellido),
           telefono: moor.Value(c.telefono),
           email: moor.Value(c.email),
           vigente: moor.Value(false)
         )
       );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createCliente(Cliente c) async {
    final _url = Uri.https(_urlBase, 'api/v1/clients', {
      'nombre': c.nombre,
      'apellido': c.apellido,
      'telefono': c.telefono,
      'email': c.email
    });
    try {
      final res = await http.post(_url);
      print(res.statusCode);
      print(res.body);
      if(res.statusCode == 201){
        final decodedData = json.decode(res.body);
       await _db.clientesDao.insertCliente(
         ClientesCompanion(
           idCliente: moor.Value(decodedData['id']),
           nombre: moor.Value(decodedData['nombre']),
           apellido: moor.Value(decodedData['apellido']),
           telefono: moor.Value(decodedData['telefono']),
           email: moor.Value(decodedData['email']),
           vigente: moor.Value(false)
         )
       );
      }
      return true;
    } catch (e) {
      return false;
    }
  }


  Future<bool> updateCliente(Cliente c) async {
    final _url = Uri.https(_urlBase, 'api/v1/clients/${c.idCliente.toString()}', {
      'nombre': c.nombre,
      'apellido': c.apellido,
      'telefono': c.telefono,
      'email': c.email
    });
    try {
      final res = await http.patch(_url);
      print(res.statusCode);
      print(res.body);
      if(res.statusCode == 200){
        final decodedData = json.decode(res.body);
       await _db.clientesDao.insertCliente(
         ClientesCompanion(
           idCliente: moor.Value(decodedData['id']),
           nombre: moor.Value(decodedData['nombre']),
           apellido: moor.Value(decodedData['apellido']),
           telefono: moor.Value(decodedData['telefono']),
           email: moor.Value(decodedData['email']),
           vigente: moor.Value(false)
         )
       );
      }
      return true;
    } catch (e) {
      return false;
    }
  }


   Future<List<Cliente>> searchClientes(String query) async {
    final _url = Uri.https(_urlBase, 'api/v1/clients/search/$query.json');
    List<Cliente> _clientes = new List<Cliente>();
    try {
      final res = await http.get(_url);
      if(res.statusCode == 200){
       _clientes = new List<Cliente>();
       final List decodedData = json.decode(res.body);
          decodedData.forEach((element) {
          final Cliente c = new Cliente(
            idCliente: element['id'],
            nombre: element['nombre'],
            apellido: element['apellido'],
            telefono: element['telefono'],
            email: element['email'],
            vigente: false
          );
          _clientes.add(c);
        });
    }
    return _clientes;
    } catch (e) {
      return _clientes;
    }
  }

   void _fetchClientesDB(List<Cliente> catList) {
    if(catList.isNotEmpty){
      catList.forEach((element) async {
       final cliente = ClientesCompanion(
         idCliente: moor.Value(element.idCliente),
         nombre: moor.Value(element.nombre),
         apellido: moor.Value(element.apellido),
         telefono: moor.Value(element.telefono),
         email: moor.Value(element.email),
         vigente: moor.Value(element.vigente)
       );

     // List<Cliente> res = await _db.clientesDao.findCliente(element.idCliente);
     // if(res.length == 0){
        await _db.clientesDao.insertCliente(cliente);
      //}else{
      //  await _db.clientesDao.updateCliente(cliente);
     // }
     });
    }
  }

}