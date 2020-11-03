import 'package:connectivity/connectivity.dart';
import 'package:demo/database/database.dart';
import 'package:demo/provider/clientes_provider.dart';
import 'package:demo/widgets/internet_status_widget.dart';
import 'package:demo/widgets/voice_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClienteSearch extends SearchDelegate{
  
  ClientesDao clientesDao;
  ClientesProvider clientesProvider;

  ClienteSearch({@required this.clientesDao, @required this.clientesProvider});
  
 

  void voiceResult(BuildContext context) async {
     final con = await Connectivity().checkConnectivity();
    if(con != ConnectivityResult.none){
        query = await showDialog(context: context,barrierDismissible: false ,builder: (context) => VoiceSearch(),);
    }else{
      Fluttertoast.showToast(msg: 'No tienes conexión a internet', toastLength: Toast.LENGTH_SHORT);
    }
  }

    @override
   ThemeData appBarTheme(BuildContext context) => ThemeData.dark().copyWith(
     primaryColor: Theme.of(context).primaryColor
   );

  @override
  List<Widget> buildActions(BuildContext context) {
      return  [
      IconButton(
        icon: (query.isEmpty) ? Icon(Icons.mic) : Icon(Icons.clear),
        onPressed: ()  {
          if(query.isEmpty){
            voiceResult(context);
          }else{
            query = '';
          }
        },
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        ),
      onPressed: () {
        close(context, null);
      });
    }
  
    @override
    Widget buildResults(BuildContext context) {
       return Column(
      children: [
        InternetWidget(
          hasInternet: _clientesOnline(false),
          noInternet: _clientesLocal(false),
        ),
      ],
    );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      
    return Column(
      children: [
        InternetWidget(
          hasInternet: _clientesOnline(true),
          noInternet: _clientesLocal(true),
        ),
      ],
    );
  }

  Widget _clientesOnline(bool suggestion){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Cliente>>(
          future: (query.isEmpty) ? clientesProvider.getClientes() : clientesProvider.searchClientes(query),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return (snapshot.data.length == 0) ? noResults(context) : 
              (suggestion) ? _suggestionListView(context, snapshot.data) : _customListView(context, snapshot.data)
              ; 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

  Widget _clientesLocal(bool suggestion){
    return Expanded(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder<List<Cliente>>(
          future: clientesDao.getAllClientes(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              final List<Cliente> clien = snapshot.data;
              final filtradas = (query.isEmpty) ? clien ?? [] : clien.where((p) => p.nombre.toLowerCase().startsWith(query.toLowerCase())).toList();
              return (filtradas.length == 0) ? noResults(context) : 
              (suggestion) ? _suggestionListView(context, filtradas)  : _customListView(context, filtradas)
              ; 
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
          },
        ),
      ) 
    );
  }

  Widget _suggestionListView(BuildContext context, List<Cliente> clientes){
    return ListView(
      children: 
        clientes.map((e) => 
          ListTile(
            onTap: () { 
              /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListProductsPage(category: e,),));*/
             },
          leading: Icon(Icons.search),
          title: Text(e.nombre+" "+e.apellido),
        )
        ).toList(),
    );
  }

  Widget _customListView(BuildContext context, List<Cliente> clientes) {
    var listView = ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text(clientes[index].nombre[0]+''+clientes[index].apellido[0], style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),),
          ),
          title: Text(clientes[index].nombre+' '+clientes[index].apellido, style: Theme.of(context).textTheme.title,),
          subtitle: Text(clientes[index].email, style: Theme.of(context).textTheme.subtitle1,),
          onTap: (){},
        ),
      ); 
      
      return Padding(padding: EdgeInsets.all(5) ,child: listView);
  }


  Widget noResults(BuildContext context){
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.youtube_searched_for, size: 64,),
            SizedBox(height: 20,),
            Text('No se encontró ninguna categoría que corresponda con \'$query\'', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
         ],
        ),
          ),
      ),
    );
  }
}