import 'package:flutter/material.dart';

  Widget _elwidget(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Ocurrió un problema :('),
        RaisedButton(onPressed: (){ setState(() {
          
        });; }, child: Text('Intentelo de nuevo'),),
      ],),
    );
  }