import 'package:demo/database/database.dart';
import 'package:demo/pages/tabs/clients_page/local%20widgets/delete_cliente_dialog.dart';
import 'package:demo/pages/tabs/clients_page/local%20widgets/edit_cliente_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClienteDetallePage extends StatefulWidget {

  final Cliente c;

  ClienteDetallePage({Key key, @required this.c}) : super(key: key);

  @override
  _ClienteDetallePageState createState() => _ClienteDetallePageState();
}

class _ClienteDetallePageState extends State<ClienteDetallePage> {

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final clientesDao = Provider.of<ClientesDao>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: (){
            showMaterialModalBottomSheet(
                context: context,
                isDismissible: true,
               // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular()),
                builder: (context, scrollController) => Container(
                  child: Wrap(
                  children: [
                  ListTile(leading: Icon(Icons.edit), title: Text('Editar Cliente'),
                    onTap: (){
                      Navigator.of(context).pop();
                      showDialog(
                            context: context,
                            child: EditCliente(c: widget.c,),
                            barrierDismissible: false,
                          );
                    },
                  ),
                  ListTile(leading: Icon(Icons.delete), title: Text('Eliminar Cliente'),
                    onTap: (){
                      Navigator.of(context).pop();
                      showDialog(
                            context: context,
                            child: DeleteCliente(cliente: widget.c,),
                            barrierDismissible: false,
                          );
                      
                    },
                  ),
                  ],
                 ),
                ),
              );
          }),
        ],
      ),
      body: StreamBuilder<List<Cliente>>(
        stream: clientesDao.watchFindCliente(widget.c.idCliente),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return _buildContent(context, isPortrait, snapshot.data[0]);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  ListView _buildContent(BuildContext context, bool isPortrait, Cliente c) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      children: [
        Stack(
          overflow: Overflow.visible,
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profile-background.jpg'),
                  fit: BoxFit.cover
                  )
              ),
            ),
            Positioned(
              top: isPortrait ? MediaQuery.of(context).size.height/5.75 : MediaQuery.of(context).size.height/7.25,
              left: 20,
              child: CircleAvatar(
                child: Text('${c.nombre[0].toUpperCase()}${c.apellido[0].toUpperCase()}', style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        Container(height: isPortrait ? MediaQuery.of(context).size.height/14 : MediaQuery.of(context).size.height/6),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('${c.nombre} ${c.apellido}', style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),)
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Text('Contacto de cliente', style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.normal),)
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _clienteFields(context, c),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text('Reservas realizadas por ${c.nombre}', style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),),
        ),

         Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text('Ventas realizadas a ${c.nombre}', style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),),
        ),
        
        

      ],
    );
  }



  Widget _clienteFields(BuildContext context, Cliente c){
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 10,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 0),child: InkWell(
          onTap: () async {
            var url = 'tel:+503 ${c.telefono.toString()}';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
          child: providerData(context, Icons.phone, c.telefono))),
         SizedBox(height: 10,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 0),child: InkWell(
          onTap: () async {
            var url = 'mailto: ${c.email}';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: providerData(context, Icons.mail, c.email))),
      ],
    );
  }

  Widget providerData(BuildContext context, IconData icono, String text){
  final size = MediaQuery.of(context).size;
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      Icon(icono,size: 28, color: Colors.blue,),
      SizedBox(width: 20,),
      Container(
        width: size.width*0.5,
        child: Text(text, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,))
    ],
  );
}




}