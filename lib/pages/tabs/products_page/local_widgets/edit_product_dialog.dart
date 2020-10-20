import 'package:demo/database/database.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  
  final int id;
  EditProduct({Key key,this.id}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  final formKey = GlobalKey<FormState>();
  String _codigo = '';
  String _descripcion = '';
  String _existencia;
  String _specification = '';


  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ProductosDao>(context);
    final screen = MediaQuery.of(context).size;
    return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
       title: Text('Editar Producto'),
       content: SingleChildScrollView(
         child: Container(
           height: screen.height*0.5,
           width: screen.width,
           child: FutureBuilder<List<Producto>>(
             future: dao.findProduct(widget.id),
             builder: (context, snapshot) {
               if(snapshot.hasData){
                 return _buildForm(snapshot.data[0]);
               }else{
                 return Center(child: CircularProgressIndicator(),);
               }
             },
            ),
         ),
       ),
       actionsPadding: EdgeInsets.symmetric(horizontal: 5),
       actions: [
         _createButton(context, 'Guardar cambios'),
         FlatButton(child: Text('Cerrar'), onPressed: () => Navigator.of(context).pop(),),
       ],
    );
  }


  Widget _createButton(BuildContext context, String name){

     return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.symmetric(vertical: 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Guardar cambios')
          ),
          elevation: 0.0,
          textColor: Colors.white,
          onPressed: () { _submit(context); },
        );
  }

  Widget _buildForm(Producto producto) {
    final focus = FocusNode();
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _codigoTextField(producto.codigo, focus),
          _descripcionTextField(producto.descripcion, focus),
          _existenciaTextField(producto.existencia.toString(), focus),
          _specificationTextField(producto.specifications, focus),
        ],
      ),
    );
  }

  Widget _codigoTextField(String code, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.text,
         maxLines: 1,
         initialValue: code,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.code, color: Colors.blue,),
         hintText: 'Código',
         labelText: 'Código del producto',
          //counterText: snapshot.data,
          //errorText: snapshot.error,
            ),
         onSaved: (d) => _codigo = d,
         validator: (value){
            if (value.length == 0) { return 'El código no puede ir vacía'; 
            }else { return null; }
         },
          ),
        );
}

 Widget _descripcionTextField(String desc, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.text,
         //textInputAction: TextInputAction.next,
          textInputAction: TextInputAction.next,
         initialValue: desc,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.description, color: Colors.blue,),
         hintText: 'Descripción',
         labelText: 'Descripción del producto',
          //counterText: snapshot.data,
          //errorText: snapshot.error,
            ),
         onSaved: (d) => _descripcion = d,
         validator: (value){
            if (value.length == 0) { return 'La descripción no puede ir vacía'; 
            }else { return null; }
         },
          ),
        );
}

 Widget _existenciaTextField(String cant, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.number,
         //textInputAction: TextInputAction.next,
         maxLines: 1,
         initialValue: cant,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.queue, color: Colors.blue,),
         hintText: 'Existencia',
         labelText: 'Existencia',
         counterText: 'unidades',
          //counterText: snapshot.data,
          //errorText: snapshot.error,
            ),
         onSaved: (d) => _existencia = d,
         validator: (value){
            if (value.length == 0) { return 'La existencia no puede ir vacía'; 
            }else { return null; }
         },
          ),
        );
}

Widget _specificationTextField(String spec, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.multiline,
         //textInputAction: TextInputAction.next,
         maxLines: 1,
         initialValue: spec,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.bookmark, color: Colors.blue,),
         hintText: 'Especificación',
         labelText: 'Especificación',
          //counterText: snapshot.data,
          //errorText: snapshot.error,
            ),
         onSaved: (d) => _specification = d,
         validator: (value){
            if (value.length == 0) { return 'La especificación no puede ir vacía'; 
            }else { return null; }
         },
          ),
        );
}

_submit(BuildContext context) async {
  final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
  final dao = Provider.of<ProductosDao>(context, listen: false);
  List<Producto> p = await dao.findProduct(widget.id);
  if(formKey.currentState.validate()){
    formKey.currentState.save();
    Producto x = new Producto(
      idProducto: p[0].idProducto,
      codigo: _codigo,
      descripcion: _descripcion,
      existencia: int.parse(_existencia),
      specifications: _specification,
      providerId: p[0].providerId,
      categoryId: p[0].categoryId
    );
    bool ans = await productsProvider.updateProduct(x);
    if(ans){
      Fluttertoast.showToast(msg: 'Producto actualizado exitosamente', toastLength: Toast.LENGTH_LONG);
    }else{
      Fluttertoast.showToast(msg: 'Ocurrió un problema, inténtalo más tarde', toastLength: Toast.LENGTH_LONG);
    }
    Navigator.of(context).pop();
  }
}


}