
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/clients_page/add_cliente_page.dart';
import 'package:demo/pages/tabs/clients_page/cliente_detalle_page.dart';
import 'package:demo/pages/tabs/clients_page/local%20widgets/search_clientes_delegate.dart';
import 'package:demo/provider/clientes_provider.dart';
import 'package:demo/widgets/error_widget.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClientsPage extends StatefulWidget {
  ClientsPage({Key key}) : super(key: key);

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> with AutomaticKeepAliveClientMixin {


  GlobalKey<ScaffoldState> scaffoldKey;


  @override
  void initState() { 
    super.initState();
    scaffoldKey = GlobalKey(debugLabel: 'clientes');
    Future.delayed(Duration.zero, () async {
       final p = Provider.of<ClientesProvider>(context, listen: false);
       await p.getClientes();
     });
  }

  Future<Null> refresh() async {
     final p = Provider.of<ClientesProvider>(context, listen: false);
     final connection = await Connectivity().checkConnectivity();
    final duration = new Duration(
      seconds: 2
    );
    Timer(duration, () {
      //setState(() {
       if(connection != ConnectivityResult.none){
          p.getClientes();
       }
      //});
    });
   return Future.delayed(duration, (){
     mostrarSnackBar((connection == ConnectivityResult.none) ? 'No tienes conexión a internet' : 'Clientes actualizadas');
   });
  }

   mostrarSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.brown,
    ));
   }

  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Clientes'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            final _dao = Provider.of<ClientesDao>(context, listen: false);
            final _clientesProvider = Provider.of<ClientesProvider>(context, listen: false);
             showSearch(
                context: context, 
                delegate: ClienteSearch(clientesDao: _dao, clientesProvider: _clientesProvider)
              );
          },),
        ],
      ),
      body: SafeArea(
          child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
            InternetWidget(
                hasInternet: _showClientesDB(context), 
                noInternet: _showClientesDB(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group_add),
        heroTag: 'clientes',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCliente(),));
        }
      ),
    );
  }

  Widget _showClientesDB(BuildContext context) {
    final catProvider = Provider.of<ClientesDao>(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: StreamBuilder<List<Cliente>>(
          stream: catProvider.watchAllClientes(),
          builder: (context, snapshot){
              if(snapshot.hasData){
                final List<Cliente> lista = snapshot.data;
                return (lista.length == 0) ? Center(child: CircularProgressIndicator(),) : 
                    _customClientesView(snapshot, true, context);
              } else{
                return TextErrorWidget(buttonFunction: (){ refresh(); });
              }
          },
        ),
      ),
    );
  }


  Widget _customClientesView(AsyncSnapshot<List<Cliente>> clientes, bool flag, BuildContext context) {
    var listView = ListView.builder(
        itemCount: clientes.data.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text(clientes.data[index].nombre[0]+''+clientes.data[index].apellido[0], style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),),
          ),
          title: Text(clientes.data[index].nombre+' '+clientes.data[index].apellido, style: Theme.of(context).textTheme.title,),
          subtitle: Text(clientes.data[index].email, style: Theme.of(context).textTheme.subtitle1,),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClienteDetallePage(c: clientes.data[index],),));
          },
        ),
      ); 
      
      return (flag) ? RefreshIndicator(
            onRefresh: refresh,
              child: listView,
        ) : listView;
  }

  @override
  bool get wantKeepAlive => true;
}