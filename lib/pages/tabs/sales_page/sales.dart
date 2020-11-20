import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  SalesPage({Key key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
      ),
      body: Center(
        child: Text('Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.of(context).pushNamed('addSales');
         },
        heroTag: 'Ventas_fab',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
