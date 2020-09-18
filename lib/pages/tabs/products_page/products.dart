import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/products_page/local_widgets.dart';
import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:demo/provider/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  Widget build(BuildContext context) {
    final _categoriesProvider = Provider.of<CategoriesProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: FutureBuilder<List<Categorie>>(
          future: _categoriesProvider.getCategories(),
          builder: (context, snapshot){
              if(snapshot.hasData){
                return  _customGridView(snapshot);
              }
          },
        ),
      ),
    );
  }

  GridView _customGridView(AsyncSnapshot<List<Categorie>> categories) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        children: categories.data.map((category) => CustomCardView(title: category.name) ).toList()
      );
  }
}