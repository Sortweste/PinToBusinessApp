import 'package:demo/models/productos_categoria_model.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/search_categories_delegate.dart';
import 'package:flutter/material.dart';

enum CartState {
  normal,
  cart,
}

class SalesProvider with ChangeNotifier {

  CartState cartState  = CartState.normal;
  List<ProductosCategoria> _carrito = new List();

  addToCart(ProductosCategoria pc){
    this._carrito.add(pc);
    notifyListeners();
  }

  List<ProductosCategoria> get carrito => this._carrito;

  getTotalAmount(){
    double total = 0;
    this._carrito.forEach((element) {
      total += (element.cantidad * element.precioSeleccionado);
     });
     return total.toStringAsFixed(2);
  }

  void changeToNormal(){
    cartState = CartState.normal;
    notifyListeners();
  }

  void changeToCart(){
    cartState = CartState.cart;
    notifyListeners();
  }

}