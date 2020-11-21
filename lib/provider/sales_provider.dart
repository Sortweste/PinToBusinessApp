import 'package:demo/models/productos_categoria_model.dart';
import 'package:flutter/material.dart';

enum CartState {
  normal,
  cart,
}

  int item = 0;


class SalesProvider with ChangeNotifier {
  CartState cartState = CartState.normal;
  List<ProductosCategoria> _carrito = new List();

  int get items => item;

  void addToCart(ProductosCategoria pc) {
    this._carrito.add(pc);
    item = this.carrito.length;
    notifyListeners();
  }

  List<ProductosCategoria> get carrito => this._carrito;

  void clearCart(){
    this._carrito = new List();
    notifyListeners();
  }


  getTotalAmount() {
    double total = 0;
    this._carrito.forEach((element) {
      total += (element.cantidad * element.precioSeleccionado);
    });
    return total.toStringAsFixed(2);
  }

  void changeToNormal() {
    cartState = CartState.normal;
    notifyListeners();
  }

  void changeToCart() {
    cartState = CartState.cart;
    notifyListeners();
  }
}
