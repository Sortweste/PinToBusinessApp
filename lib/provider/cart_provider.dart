import 'package:demo/models/productos_categoria_model.dart';
import 'package:flutter/material.dart';

class CarritoProvider with ChangeNotifier {
  List<ProductosCategoria> _carrito = new List();
  int _items = 0;

  addToCart(ProductosCategoria pc) {
    this._carrito.add(pc);
    _items = this._carrito.length;
    notifyListeners();
  }

  int get items => this._carrito.length;

  List<ProductosCategoria> get carrito => this._carrito;

  getTotalAmount() {
    double total = 0;
    this._carrito.forEach((element) {
      print(element);
      //double mult = element.cantidad * element.precioSeleccionado;
      //total += mult;
    });
    //notifyListeners();
    return '3.50';
  }
}
