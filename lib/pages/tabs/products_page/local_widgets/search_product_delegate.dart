import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/custom_product_card.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:demo/widgets/voice_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../product_detail.dart';

class ProductSearch extends SearchDelegate{
  
  ProductosDao productosDao;
  ProductsProvider productosProvider;
  List<Producto> products;
  int categoryId;
  List<Producto> listaSugerida;
  ProductSearch({@required this.productosDao, @required this.productosProvider, @required this.categoryId}){
     initialize();
  }
  
  void initialize() async {
    products = await productosDao.singleProduct(categoryId);
    final con = await Connectivity().checkConnectivity();
    if(con != ConnectivityResult.none){
       //categoriesProvider.requestCategories();
    }
  }

  void voiceResult(BuildContext context) async {
     final con = await Connectivity().checkConnectivity();
    if(con != ConnectivityResult.none){
        query = await showDialog(context: context,barrierDismissible: false ,builder: (context) => VoiceSearch(),);
    }else{
      Fluttertoast.showToast(msg: 'No tienes conexión a internet', toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
      return  [
      IconButton(
        icon: (query.isEmpty) ? Icon(Icons.mic) : Icon(Icons.clear),
        onPressed: ()  {
          if(query.isEmpty){
            voiceResult(context);
          }else{
            query = '';
          }
        },
        ),
      ];
    }

   @override
   ThemeData appBarTheme(BuildContext context) => ThemeData.dark().copyWith(
     primaryColor: Theme.of(context).primaryColor
   );
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        ),
      onPressed: () {
        close(context, null);
      });
    }
  
    @override
    Widget buildResults(BuildContext context) {
       return Column(
      children: [
        InternetWidget(
          hasInternet: _productsOnline(false),
          noInternet: _productsLocal(false),
        ),
      ],
    );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      
    return Column(
      children: [
        InternetWidget(
          hasInternet: _productsOnline(true),
          noInternet: _productsLocal(true),
        ),
      ],
    );
  }

  Widget _productsOnline(bool suggestion){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Producto>>(
          future: (query.isEmpty) ? productosProvider.getAllProducts(categoryId) : productosProvider.searhProducts(query, categoryId),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return (snapshot.data.length == 0) ? noResults(context) : 
              (suggestion) ? _suggestionListView(context, snapshot.data)  : 
               ListView.builder(
                     itemCount: snapshot.data.length,
                     itemBuilder: (context, index){
                       return CustomProductCard(product: snapshot.data[index]);
                     //return ListTile(title: Text(lista[index].descripcion), subtitle: Text(lista[index].idProducto.toString()),);
                  }
                   ); 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

   Widget _productsLocal(bool suggestion){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Producto>>(
          future: productosDao.singleProduct(categoryId),
          builder: (context, snapshot){
            if(snapshot.hasData){
              final List<Producto> lista = snapshot.data;
              final filtrada = (query.isEmpty) ? lista : lista.where((p) => p.descripcion.toLowerCase().startsWith(query.toLowerCase())).toList();
              return (filtrada.length == 0) ? noResults(context) : 
              (suggestion) ? _suggestionListView(context, filtrada)  : 
               ListView.builder(
                     itemCount: filtrada.length,
                     itemBuilder: (context, index){
                       return CustomProductCard(product: filtrada[index]);
                     //return ListTile(title: Text(lista[index].descripcion), subtitle: Text(lista[index].idProducto.toString()),);
                  }
                   ); 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

  Widget _productsOfflineSearch(BuildContext context, bool suggestion) {
   
    fillProudcts();

    return Expanded(
      child: (query.isNotEmpty && listaSugerida.length==0) ? noResults(context) : 
        (suggestion) ? _suggestionListView(context, listaSugerida)  : 
         ListView.builder(
                     itemCount: listaSugerida.length,
                     itemBuilder: (context, index){
                       return CustomProductCard(product: listaSugerida[index]);
                     //return ListTile(title: Text(lista[index].descripcion), subtitle: Text(lista[index].idProducto.toString()),);
                  }
                   ),
    );
  }

  void fillProudcts() async {
    products = await productosDao.singleProduct(categoryId);
    listaSugerida = (query.isEmpty) ? products : 
    products.where((p) => p.descripcion.toLowerCase().startsWith(query.toLowerCase())).toList();
  }

  Widget _suggestionListView(BuildContext context, List<Producto> categories){
    return ListView(
      children: 
        categories.map((e) => 
          ListTile(
            onTap: () { 
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(id: e.idProducto,),));
             },
          leading: Icon(Icons.search),
          title: Text((e.descripcion == "No disponible") ? e.codigo : e.descripcion),
        )
        ).toList(),
    );
  }




  Widget noResults(BuildContext context){
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.youtube_searched_for, size: 64,),
            SizedBox(height: 20,),
            Text('No se encontró ninguna producto que corresponda con \'$query\'', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
         ],
        ),
          ),
      ),
    );
  }
}