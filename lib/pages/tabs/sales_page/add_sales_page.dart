import 'package:demo/database/database.dart';
import 'package:demo/models/productos_categoria_model.dart' as pcat;
import 'package:demo/pages/tabs/sales_page/add_product_to_cart_dialog.dart';
import 'package:demo/provider/cart_provider.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:demo/provider/sales_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSalesPage extends StatefulWidget {
  @override
  _AddSalesPageState createState() => _AddSalesPageState();
}

class _AddSalesPageState extends State<AddSalesPage> {
  final Duration _transition = Duration(milliseconds: 250);

  SalesProvider salesProvider;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final c = Provider.of<CarritoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size.height;
    salesProvider = Provider.of<SalesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Venta'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedPositioned(
                  //key: widget.key,
                  duration: _transition,
                  left: 0,
                  right: 0,
                  top: getTopCategoriesPanel(
                      salesProvider.cartState, MediaQuery.of(context).size),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    height: size - 150,
                    child: Column(
                      children: [
                        _buildProducts(context),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _transition,
                  left: 0,
                  right: 0,
                  top: getTopCartPanel(
                      salesProvider.cartState, MediaQuery.of(context).size),
                  child: Container(
                    height: size,
                    padding: EdgeInsets.only(bottom: 75),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Consumer<SalesProvider>(
                          builder: (context, value, child) => AnimatedBuilder(
                            animation: value,
                            builder: (context, child) => GestureDetector(
                              onVerticalDragUpdate: _update,
                              onTap: _actualizar,
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 36,
                                    ),
                                    Text(
                                      '${salesProvider.carrito.length}',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Expanded(
                                        child: Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 36,
                                    )),
                                    Icon(
                                      Icons.monetization_on,
                                      size: 36,
                                    ),
                                    Text('${salesProvider.getTotalAmount()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 3,
                              child: RaisedButton(
                                onPressed: () {
                                  salesProvider.clearCart();
                                },
                                child: Text('Eliminar todo'),
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: RaisedButton(
                                onPressed: () {},
                                color: Colors.blueGrey,
                                child: Text('Procesar venta'),
                              ),
                            ),
                          ],
                        ),
                        _buildShoppingCart(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _actualizar() {
    setState(() {});
  }

  void _update(DragUpdateDetails details) {
    if (details.primaryDelta < -5) {
      salesProvider.changeToCart();
    } else if (details.primaryDelta > 5) {
      salesProvider.changeToNormal();
    }
  }

  double getTopCategoriesPanel(CartState cs, Size size) {
    if (cs == CartState.normal) {
      return 10;
    } else {
      return -size.height + 200;
    }
  }

  double getTopCartPanel(CartState cs, Size size) {
    if (cs == CartState.normal) {
      return size.height - 130;
    } else {
      return 0;
    }
  }

  Widget _buildProducts(BuildContext context) {
    final productosProvider = Provider.of<ProductsProvider>(context);
    final dao = Provider.of<ProductosDao>(context);
    return Expanded(
      child: FutureBuilder<List<pcat.ProductosCategoria>>(
        future: productosProvider.getSalesProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${snapshot.data[index].descripcion}'),
                  subtitle: Text('${snapshot.data[index].codigo}'),
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.add_shopping_cart),
                  isThreeLine: false,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) =>
                          AddProductToCart(producto: snapshot.data[index]),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildShoppingCart(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: salesProvider.carrito.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${salesProvider.carrito[index].descripcion}'),
            subtitle:
                Text('Cantidad: ${salesProvider.carrito[index].cantidad}'),
            trailing:
                Text('\$${salesProvider.carrito[index].precioSeleccionado.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
