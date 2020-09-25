
import 'package:flutter/material.dart';


class ClientsPage extends StatefulWidget {
  ClientsPage({Key key}) : super(key: key);

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> with AutomaticKeepAliveClientMixin {


  @override
  void initState() { 
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('clientes');
   
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(child: Text('Clientes Page'),),
    );
  }

  @override
  bool get wantKeepAlive => true;
}