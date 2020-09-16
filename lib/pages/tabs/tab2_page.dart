import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  Tab2Page({Key key}) : super(key: key);

  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {

  @override
  Widget build(BuildContext context) {
     final _navigationProvider = Provider.of<TabsNavigationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('Page'),
      ),
    );
  }
}