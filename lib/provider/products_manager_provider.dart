import 'package:flutter/material.dart';

class ProductsManager with ChangeNotifier {
   String _color = '';
   Color _currentColor = Colors.transparent;
   String _selectedSize = ''; 
   
  
   setIni(String c, String s, Color cr){
     this._color = c;
     this._currentColor = cr;
     this._selectedSize = s;
   }

   setColorString(String c){
     this._color = c;
     notifyListeners();
   }

   setSelectedSize(String s){
     this._selectedSize = s;
     notifyListeners();
   }

   String get color => this._color;

    setCurrentColor(Color c){
     this._currentColor = c;
     notifyListeners();
   }

   Color get currentColor => this._currentColor;

   String get selectedSize => this._selectedSize;

}