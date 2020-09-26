import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/custom_card_view.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/custom_product_dialog.dart';
import 'package:demo/provider/categories_provider.dart';
import 'package:demo/provider/tallas_provider.dart';
import 'package:demo/provider/colores_provider.dart';
import 'package:demo/widgets/error_widget.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with AutomaticKeepAliveClientMixin {

  GlobalKey<ScaffoldState> scaffoldKey;


  
  @override
  void initState() { 
    super.initState();
    scaffoldKey = GlobalKey(debugLabel: 'productos');
     Future.delayed(Duration.zero, (){
       Provider.of<CategoriesProvider>(context, listen: false).requestCategories();
     });
  }



   Future<Null> refresh() async {
     final p = Provider.of<CategoriesProvider>(context, listen: false);
     final connection = await Connectivity().checkConnectivity();
    final duration = new Duration(
      seconds: 2
    );
    Timer(duration, () {
      //setState(() {
       if(connection != ConnectivityResult.none){
          p.requestCategories();
       }
      //});
    });
   return Future.delayed(duration, (){
     mostrarSnackBar((connection == ConnectivityResult.none) ? 'No tienes conexión a internet' : 'Categorías actualizadas');
   });
  }

   mostrarSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.brown,
    ));
   }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _categoriesProvider = Provider.of<CategoriesProvider>(context, listen: true);
    final _coloresProvider = Provider.of<ColoresProvider>(context, listen: false);
    final _tallasProvider = Provider.of<TallasProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Productos',),),
      body: SafeArea(
          child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
            InternetWidget(
                hasInternet: _showCategories(context, _categoriesProvider), 
                noInternet: _showCategoriesDB(context, _categoriesProvider),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final colores = await _coloresProvider.getColores();
        final tallas = await _tallasProvider.getTallas();
        showDialog(
          context: context,
          builder: (BuildContext context){
            return CustomProductDialog(title: 'Colores', imageUrl: 'https://lh3.googleusercontent.com/pw/ACtC-3cZWLy5d7yiW_81wpDyjFJ_gtiC0s9u3LOGqn9tJDluEs0OO1-oq7iSTm0asfMh83urAKn0dNSB5SuKo1BeWXk7w8YHEr_6cdi0p1_VoMI6T5vyPlCAbZLBWss2HG5VdSyjbYOu2_r0ajMS2yqSc3VG=w1236-h827-no',colores: colores, tallas: tallas,);
            }
        );  
      }),
    );
  }



  Widget _showCategoriesDB(BuildContext context, CategoriesProvider p) {
    final catProvider = Provider.of<CategoriesDao>(context);
    return Expanded(
      child: StreamBuilder(
        stream: catProvider.watchAllCategories(),
        builder: (context, snapshot){
            if(snapshot.hasData){
              final List<Categorie> lista = snapshot.data;
              return (lista.length == 0) ? TextErrorWidget(
                buttonFunction: (){ 
                  mostrarSnackBar('No tienes conexión a internet'); 
                  }) : 
                  _customGridView(snapshot, true);
            } else{
              return TextErrorWidget(buttonFunction: (){ refresh(); });
            }
        },
      ),
    );
  }



  Widget _showCategories(BuildContext context, CategoriesProvider _categoriesProvider) {
    return Expanded(
      child: FutureBuilder<List<Categorie>>(
        future: _categoriesProvider.categories,
        builder: (context, snapshot){
            if(snapshot.hasData){
              return (snapshot.data.isEmpty) ?  TextErrorWidget(buttonFunction: (){ 
                refresh();   
              }) : 
                _customGridView(snapshot, true);
            }else{
              return Center(
                child: CircularProgressIndicator(),
                );
            }

        },
      ),
    );
  }


  Widget _customGridView(AsyncSnapshot<List<Categorie>> categories, bool flag) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var gridView = GridView.count(
              crossAxisCount: (isPortrait) ? 2 : 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              children: categories.data.map((category) => CustomCardView(title: category.name, imageURL: category.imageurl,) ).toList()
            );
        return (flag) ? RefreshIndicator(
            onRefresh: refresh,
              child: gridView,
        ) : gridView;
  }

  

  @override
  bool get wantKeepAlive => true;
}