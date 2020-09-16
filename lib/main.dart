import 'package:demo/pages/bottom_nav_menu_page.dart';
import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabsNavigationProvider(),),
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
      },
    );
  }
}