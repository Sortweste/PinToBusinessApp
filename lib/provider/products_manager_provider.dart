import 'package:flutter/material.dart';

class ProductsManager with ChangeNotifier {
   String _color = 'Verde';
   Color _currentColor = Colors.limeAccent; 
   
   ProductsManager(){
     this._color = 'Verde';
     this._currentColor = Colors.limeAccent;
     notifyListeners();
   }  
   

   setColorString(String c){
     this._color = c;
     notifyListeners();
   }

   String get color => this._color;

    setCurrentColor(Color c){
     this._currentColor = c;
     notifyListeners();
   }

   Color get currentColor => this._currentColor;

}