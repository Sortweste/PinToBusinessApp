/*
 * FindMyProduct app
 * Copyright (C) 2020 hugopinto1997
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void showModal(BuildContext context, String error){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Ocurrió un problema'),
        content: Text('$error'),
        actions: <Widget>[
          FlatButton(child: Text('Cerrar'), onPressed: () => Navigator.of(context).pop(),),
        ],
      );
    }, 
  );
}

void logout(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setInt('id', 0);
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, 'login');
  }