import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
         child: Text('Page'),
      ),
    );
  }
}