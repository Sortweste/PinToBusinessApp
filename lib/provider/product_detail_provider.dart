import 'package:flutter/material.dart';

class ProductDetail with ChangeNotifier {
  bool _fondo = false;
  ScrollController _scrollController;

  ProductDetail(){
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent*0.8 && !_scrollController.position.outOfRange){
          Future.delayed(Duration(milliseconds: 250), (){
             setFondo(true);
          });
        } else if  (_scrollController.offset <= _scrollController.position.minScrollExtent + 100 && !_scrollController.position.outOfRange) {
           Future.delayed(Duration(milliseconds: 250), () async {
             setFondo(false);
          });
        }
     });
  }

  reset() {
    this._fondo = false;
    notifyListeners();
    //_scrollController.jumpTo(0);
  }

  

  ScrollController get scrollController => this._scrollController;



  setFondo(bool f) {
    this._fondo = f;
    notifyListeners();
  }

  bool fondo() {
      return this._fondo;
  }
}