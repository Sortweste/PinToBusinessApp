import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
         child: Text('Page'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}