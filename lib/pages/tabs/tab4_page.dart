import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab4Page extends StatefulWidget {
  Tab4Page({Key key}) : super(key: key);

  @override
  _Tab4PageState createState() => _Tab4PageState();
}

class _Tab4PageState extends State<Tab4Page> {

  @override
  Widget build(BuildContext context) {
     final _navigationProvider = Provider.of<TabsNavigationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
         child: Text('Page'),
      ),
    );
  }
}