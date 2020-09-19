import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  ClientsPage({Key key}) : super(key: key);

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('Page'),
      ),
    );
  }
}