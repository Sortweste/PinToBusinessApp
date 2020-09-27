import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/custom_card_view.dart';
import 'package:demo/provider/categories_provider.dart';
import 'package:demo/widgets/error_widget.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  List<Widget> buildActions(BuildContext context) {
      return  [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
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
          noInternet: _categoriesOfflineSearch(context, false),
        ),
      ],
    );;
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      
    return Column(
      children: [
        InternetWidget(
          hasInternet: _categoriesOnline(false),
          noInternet: _categoriesOfflineSearch(context, false),
        ),
      ],
    );
  }

  Widget _categoriesOnline(bool online){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Categorie>>(
          future: (query.isEmpty) ? categoriesProvider.categories : categoriesProvider.searchCategories(query),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return (snapshot.data.length == 0) ? noResults(context)
                :  _customGridView(context,snapshot.data)
              ; 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

  Widget _categoriesOfflineSearch(BuildContext context, bool online){
     final List<Categorie> listaSugerida =  (query.isEmpty) ? categorias ?? [] : categorias.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();
    
    return Expanded(
      child: (query.isNotEmpty && listaSugerida.length==0) ? noResults(context): 
      Padding(padding: EdgeInsets.all(5) ,child: _customGridView(context, listaSugerida)),
    );
  }

  Widget _customGridView(BuildContext context, List<Categorie> categories) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var gridView = GridView.count(
              crossAxisCount: (isPortrait) ? 2 : 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              children: categories.map((category) => CustomCardView(title: category.name, imageURL: category.imageurl,) ).toList()
            );
        return gridView;
  }


  Widget noResults(BuildContext context){
    return Center(
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.youtube_searched_for, size: 64,),
        SizedBox(height: 20,),
        Text('No se encontró ninguna categoría que corresponda con \'$query\'', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
       ],
      ),
    );
  }
}