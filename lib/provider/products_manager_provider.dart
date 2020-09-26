import 'package:flutter/material.dart';

class ProductsManager with ChangeNotifier {
   String _color = 'Verde';
   Color _currentColor = Colors.limeAccent;
   String _selectedSize = ''; 
   
   ProductsManager(){
     this._color = 'Verde';
     this._currentColor = Colors.limeAccent;
     this._selectedSize = ''; 
     notifyListeners();
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