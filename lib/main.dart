import 'package:demo/database/database.dart';
import 'package:demo/pages/bottom_nav_menu_page.dart';
import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:demo/provider/categories_provider.dart';
import 'package:demo/provider/clientes_provider.dart';
import 'package:demo/provider/colores_provider.dart';
import 'package:demo/provider/product_detail_provider.dart';
import 'package:demo/provider/products_manager_provider.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:demo/provider/proveedor_provider.dart';
import 'package:demo/provider/tallas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/bottom_nav_menu_page.dart';
 
 AppDatabase db;
void main() {
  db = AppDatabase();
  return runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CategoriesDao>(create: (_) => db.categoriesDao,),
        Provider<ProductosDao>(create: (_) => db.productosDao,),
        Provider<ProveedoresDao>(create: (_) => db.proveedoresDao,),
        Provider<TallasDao>(create: (_) => db.tallasDao,),
        Provider<ColoresDao>(create: (_) => db.coloresDao,),
        Provider<ClientesDao>(create: (_) => db.clientesDao,),
        Provider<ClientesProvider>(create: (_) => ClientesProvider(db),),
        ChangeNotifierProvider(create: (_) => TabsNavigationProvider(),),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (context) => CategoriesProvider(db.categoriesDao),
          //update: (context, dao, cp) => CategoriesProvider(dao),
        ),
        ChangeNotifierProvider(create: (context) => ColoresProvider()),
        ChangeNotifierProvider(create: (_) => ProductsManager()),
        
        ChangeNotifierProxyProvider<TallasDao, TallasProvider>(
          create: (context) => TallasProvider(null),
          update: (context, dao, cp) => TallasProvider(dao),
        ),

          ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(db),
        ),

         ChangeNotifierProvider<ProductDetail>(
          create: (context) => ProductDetail(),
        ),
        ChangeNotifierProvider<ProveedorProvider>(
          create: (context) => ProveedorProvider(db),
        ),


      ],
      child: _MateApp(),
      );
  }
}

class _MateApp extends StatelessWidget {
  const _MateApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PinToBusiness App',
      initialRoute: 'home',
      routes: {
         'home': (BuildContext context) => HomePage(),
         /*'list_products': (BuildContext context) => ListProductsPage()*/
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Color.fromRGBO(143,65,61,1),
        
      ),
    );
  }
}

