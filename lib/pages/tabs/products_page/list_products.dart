import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:demo/widgets/error_widget.dart';
import 'package:provider/provider.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/custom_product_card.dart';

class ListProductsPage extends StatefulWidget {
  final Categorie category;
  ListProductsPage({this.category});

  @override
  _ListProductsPageState createState() => _ListProductsPageState();

}

class _ListProductsPageState extends State<ListProductsPage>{

  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() { 
    super.initState();
    scaffoldKey = GlobalKey(debugLabel: 'productos/id');
     Future.delayed(Duration.zero, () {
       final p = Provider.of<ProductsProvider>(context, listen: false);
       p.getProductos(2);
     });
  }
/*
  Future<Null> refresh() async {
    final p = Provider.of<ProductsProvider>(context, listen: false);
    final connection = await Connectivity().checkConnectivity();
    final duration = new Duration(
      seconds: 2
    );
    Timer(duration, () {
       if(connection != ConnectivityResult.none){
          p.requestProducts();
       }
    });
   return Future.delayed(duration, (){
     mostrarSnackBar((connection == ConnectivityResult.none) ? 'No tienes conexión a internet' : 'Productos Actualizados');
   });
  }*/

  mostrarSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.brown,
    ));
   }

  @override
  Widget build(BuildContext context) {
    /*final _productsProvider = Provider.of<ProductsProvider>(context, listen: true);
    argument = ModalRoute.of(context).settings.arguments;
    */
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.category.name)
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              /*InternetWidget(
                hasInternet: _showProducts(context, _productsProvider),
                noInternet: _showProductsDB(context),
              )*/
            ]
          )
        )
      )
    );
  }
/*
  Widget _showProductsDB(BuildContext context) {
    final productProvider = Provider.of<CategoriesDao>(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: StreamBuilder(
          stream: productProvider.watchAllProducts(),
          builder: (context, snapshot){
              if(snapshot.hasData){
                final List<Product> lista = snapshot.data;
                return (lista.length == 0) ? TextErrorWidget(
                  buttonFunction: (){ 
                    mostrarSnackBar('No tienes conexión a internet'); 
                    }) : 
                    _customListView(snapshot, true);
              } else{
                return TextErrorWidget(buttonFunction: (){ refresh(); });
              }
          },
        ),
      ),
    );
  }

    Widget _showProducts(BuildContext context, ProductsProvider _productsProvider) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: FutureBuilder<List<Product>>(
          future: _productsProvider.products,
          builder: (context, snapshot){
              if(snapshot.hasData){
                return (snapshot.data.isEmpty) ?  TextErrorWidget(buttonFunction: (){ 
                  refresh();   
                }) : 
                  _customListView(snapshot, true);
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

          },
        ),
      ),
    );
  }

 Widget _customListView(AsyncSnapshot<List<Product>> products, bool flag) {
    var listView = ListView.builder(
      itemCount: products.data.length,
      itemBuilder: (context, index) => CustomProductCard(product: products.data[index]), 
    );
    return (flag) ? RefreshIndicator(
      onRefresh: refresh,
      child: listView,
    ) : listView;
  }

  @override
  bool get wantKeepAlive => true;
*/
}