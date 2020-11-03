import 'package:demo/database/database.dart';
import 'package:demo/provider/clientes_provider.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DeleteCliente extends StatefulWidget {
  
  final Cliente cliente;

  DeleteCliente({Key key, this.cliente}) : super(key: key);

  @override
  _DeleteClienteState createState() => _DeleteClienteState();
}

class _DeleteClienteState extends State<DeleteCliente> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('¿Estás segur?'),
      content: Text('Se eliminará permanentemente el cliente, incluyendo las reservas y ventas de este mismo.'),
      actions: [
         _createButton(context, 'Guardar cambios'),
         FlatButton(child: Text('Cerrar'), onPressed: () => Navigator.of(context).pop(),),
      ],
    );
  }

   Widget _createButton(BuildContext context, String name){
     final clientesProvider = Provider.of<ClientesProvider>(context);
     return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Eliminar')
          ),
          elevation: 0.0,
          textColor: Colors.white,
          onPressed: () async {
             Navigator.of(context).pop();
             Navigator.of(context).pop();
            bool ans = await clientesProvider.deletCliente(widget.cliente);
            if(ans){
              Fluttertoast.showToast(msg: 'Producto eliminado exitosamente', toastLength: Toast.LENGTH_LONG);
            }else{
                Fluttertoast.showToast(msg: 'Ocurrió un problema', toastLength: Toast.LENGTH_LONG);
            }
           },
        );
  }





}