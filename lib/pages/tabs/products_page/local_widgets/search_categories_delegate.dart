import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/custom_card_view.dart';
import 'package:demo/provider/categories_provider.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:demo/widgets/voice_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../list_products.dart';

class CategorySearch extends SearchDelegate{
  
  CategoriesDao categoriesDao;
  CategoriesProvider categoriesProvider;
  List<Categorie> categorias;
  CategorySearch({@required this.categoriesDao, @required this.categoriesProvider}){
     initialize();
  }
  
  void initialize() async{
    categorias = await categoriesDao.getAllCategories();
    final con = await Connectivity().checkConnectivity();
    if(con != ConnectivityResult.none){
       categoriesProvider.requestCategories();
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
   ThemeData appBarTheme(BuildContext context) => Theme.of(context);

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
          hasInternet: _categoriesOnline(false),
          noInternet: _categoriesLocal(false),
        ),
      ],
    );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      
    return Column(
      children: [
        InternetWidget(
          hasInternet: _categoriesOnline(true),
          noInternet: _categoriesLocal(true),
        ),
      ],
    );
  }

  Widget _categoriesOnline(bool suggestion){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Categorie>>(
          future: (query.isEmpty) ? categoriesProvider.categories : categoriesProvider.searchCategories(query),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return (snapshot.data.length == 0) ? noResults(context) : 
              (suggestion) ? _suggestionListView(context, snapshot.data)  : _customGridView(context, snapshot.data)
              ; 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

  Widget _categoriesLocal(bool suggestion){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Categorie>>(
          future: categoriesDao.getAllCategories(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              final List<Categorie> categ = snapshot.data;
              final filtradas = (query.isEmpty) ? categ ?? [] : categ.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();
              return (filtradas.length == 0) ? noResults(context) : 
              (suggestion) ? _suggestionListView(context, filtradas)  : _customGridView(context, filtradas)
              ; 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

  Widget _categoriesOfflineSearch(BuildContext context, bool suggestion){
    List<Categorie> listaSugerida = new List();
    
    Future.delayed(Duration.zero, () {
       listaSugerida =  (query.isEmpty) ? categorias ?? [] : categorias.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();
    });
    
    return Expanded(
      child: (query.isNotEmpty && listaSugerida.length==0) ? noResults(context) : 
        (suggestion) ? _suggestionListView(context, listaSugerida)  : _customGridView(context, listaSugerida)
    );
  }

  Widget _suggestionListView(BuildContext context, List<Categorie> categories){
    return ListView(
      children: 
        categories.map((e) => 
          ListTile(
            onTap: () { 
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListProductsPage(category: e,),));
             },
          leading: Icon(Icons.search),
          title: Text(e.name),
        )
        ).toList(),
    );
  }

  Widget _customGridView(BuildContext context, List<Categorie> categories) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var gridView = GridView.count(
              crossAxisCount: (isPortrait) ? 2 : 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              children: categories.map((category) => CustomCardView(category: category,) ).toList()
            );
        return Padding(padding: EdgeInsets.all(5) ,child: gridView);
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
            Text('No se encontró ninguna categoría que corresponda con \'$query\'', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
         ],
        ),
          ),
      ),
    );
  }
}