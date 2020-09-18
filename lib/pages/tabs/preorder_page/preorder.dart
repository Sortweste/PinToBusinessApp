import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreorderPage extends StatefulWidget {
  PreorderPage({Key key}) : super(key: key);

  @override
  _PreorderPageState createState() => _PreorderPageState();
}

class _PreorderPageState extends State<PreorderPage> {

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