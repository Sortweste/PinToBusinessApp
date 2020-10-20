import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

class ProductsManager with ChangeNotifier {
   String _color = '';
   Color _currentColor = Colors.transparent;
   String _selectedSize = ''; 
   int _colorId = 1, _tallaId = 1;
   
  
   setIni(String c, String s, Color cr, int colId, int tallId){
     this._color = c;
     this._currentColor = cr;
     this._selectedSize = s;
     this._colorId = colId;
     this._tallaId = tallId;
   }

   setColorString(String c){
     this._color = c;
     notifyListeners();
   }

   setColorId(int c){
     this._colorId = c;
     notifyListeners();
   }

   setSelectedSize(String s){
     this._selectedSize = s;
     notifyListeners();
   }

   String get color => this._color;

   int get colorId => this._colorId;

   setCurrentColor(Color c){
     this._currentColor = c;
     notifyListeners();
   }

   setSizeId(int id){
     this._tallaId = id;
     notifyListeners();
   }

   Color get currentColor => this._currentColor;

   String get selectedSize => this._selectedSize;

   int get tallaId => this._tallaId;



}