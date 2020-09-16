import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab3Page extends StatefulWidget {
  Tab3Page({Key key}) : super(key: key);

  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> {

  @override
  Widget build(BuildContext context) {
     final _navigationProvider = Provider.of<TabsNavigationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
         child: Text('Page'),
      ),
    );
  }
}