import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  Tab1Page({Key key}) : super(key: key);

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> {

  

  @override
  Widget build(BuildContext context) {
    final _navigationProvider = Provider.of<TabsNavigationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('Page'),
      ),
    );
  }
}