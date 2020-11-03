import 'package:demo/database/database.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DeleteProduct extends StatefulWidget {
  
  final Producto producto;

  DeleteProduct({Key key, this.producto}) : super(key: key);

  @override
  _DeleteProductState createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('¿Estás segur?'),
      content: Text('Se eliminará permanentemente el producto, incluyendo los precios, colores y tallas de este mismo.'),
      actions: [
         _createButton(context, 'Guardar cambios'),
         FlatButton(child: Text('Cerrar'), onPressed: () => Navigator.of(context).pop(),),
      ],
    );
  }

   Widget _createButton(BuildContext context, String name){
     final productosProvider = Provider.of<ProductsProvider>(context);
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
            bool ans = await productosProvider.deleteProduct(widget.producto);
            if(ans){
              Fluttertoast.showToast(msg: 'Producto eliminado exitosamente', toastLength: Toast.LENGTH_LONG);
            }else{
                Fluttertoast.showToast(msg: 'Ocurrió un problema', toastLength: Toast.LENGTH_LONG);
            }
           },
        );
  }





}