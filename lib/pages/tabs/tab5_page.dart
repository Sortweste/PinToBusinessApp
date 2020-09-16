import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab5Page extends StatefulWidget {
  Tab5Page({Key key}) : super(key: key);

  @override
  _Tab5PageState createState() => _Tab5PageState();
}

class _Tab5PageState extends State<Tab5Page> {
  
  @override
  Widget build(BuildContext context) {
    final _navigationProvider = Provider.of<TabsNavigationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('Page'),
      ),
    );
  }
}