import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  Future<Map<String, dynamic>> login(String name, String password) async {
    final direccion = Uri.https('pinto-business.herokuapp.com',
        'api/v1/users/login.json', {'email': name, 'password': password});

    final resp = await http.post(direccion);

    Map<String, dynamic> token = json.decode(resp.body);

    print('Respuesta: ${token}');
    if (token.containsKey('Authorization')) {
      return {'token': token['Bearer'], 'id': token['User_id']};
    } else {
      return {'error': token['error']};
    }
  }

 
  
}
