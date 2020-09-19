import 'dart:async';
import 'dart:ffi';

import 'package:demo/database/database.dart';
import 'package:demo/provider/categories_provider.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

import 'local_widgets.dart';


class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with AutomaticKeepAliveClientMixin {

  void _fetchCategories(BuildContext context, List<Categorie> c) {
    final catDao = Provider.of<CategoriesDao>(context);
    final List<Categorie> categorias = c;
    if(categorias.isNotEmpty){
      catDao.truncateCategories();
      categorias.forEach((element) {
       final categoria = CategoriesCompanion(
         id: moor.Value(element.id),
         name: moor.Value(element.name)
       );
       catDao.insertCategory(categoria);
     });
    }
  }

  
  @override
  void initState() { 
    super.initState();
   
  }


   Future<Null> refresh() async {
    final duration = new Duration(
      seconds: 1
    );
    Timer(duration, () {
      setState(() {
      });
    });
    return Future.delayed(duration);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _categoriesProvider = Provider.of<CategoriesProvider>(context);
     final _dao = Provider.of<CategoriesDao>(context);
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return CustomProductDialog(title: 'Colores', imageUrl: 'https://lh3.googleusercontent.com/pw/ACtC-3eYAUOA-XQJhRslBlQZvESlOHYx4Ai_82Temdx3ghdqHVEre1xWUp2URWMp9ansxK5GY0uEWPNp5VCTMHHQmyx3oJNlwZbILJh8fZerkx3QCxEpCSl-8EdtDIAZ2kzIgoxEzyDFiuG0uPQzAr1x31Tg=w1103-h827-no',);
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
              final List<Categorie> res = snapshot.data;
              return (res.length == 0) ? ErrorWidget(context) : _customGridView(snapshot, false);
            }
             switch (snapshot.connectionState) {
      case ConnectionState.none: return Text('Select lot');
      case ConnectionState.waiting: return Text('Awaiting bids...');
      case ConnectionState.active: return CircularProgressIndicator();
      case ConnectionState.done: return Text('\$${snapshot.data} (closed)');
    }
        },
      ),
    );
  }



  Widget _showCategories(BuildContext context, CategoriesProvider _categoriesProvider) {
    return Expanded(
      child: FutureBuilder<List<Categorie>>(
        future: _categoriesProvider.getCategories(),
        builder: (context, snapshot){
            if(snapshot.hasData){
              _fetchCategories(context, snapshot.data);
              return (snapshot.data.isEmpty) ? ErrorWidget(context) : _customGridView(snapshot, true);
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
              children: categories.data.map((category) => CustomCardView(title: category.name) ).toList()
            );
        return (flag) ? RefreshIndicator(
            onRefresh: refresh,
              child: gridView,
        ) : gridView;
  }

  

  @override
  bool get wantKeepAlive => true;
}