import 'package:demo/database/database.dart';
import 'package:demo/provider/proveedor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EditProvider extends StatefulWidget {
  
  final Proveedore proveedor;
  EditProvider({Key key,this.proveedor}) : super(key: key);

  @override
  _EditProviderState createState() => _EditProviderState();
}

class _EditProviderState extends State<EditProvider> {

  final formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _email = '';


  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
       title: Text('Editar Proveedor'),
       content: SingleChildScrollView(
         child: Container(
           //height: screen.height*0.5,
           width: screen.width,
           child: _buildForm(widget.proveedor),
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
        color: Colors.blueGrey,
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

  Widget _buildForm(Proveedore p) {
    final focus = FocusNode();
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _nameTextField(p.name, focus),
          _emailTextField(p.email, focus),
          _phoneTextField(p.phone, focus),
        ],
      ),
    );
  }

  Widget _phoneTextField(String tel, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.phone,
         maxLines: 1,
         initialValue: tel,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.phone, color: Colors.blue,),
         hintText: 'Teléfono',
         labelText: 'Teléfono del proveedor',
        ),
         onSaved: (d) => _phone = d,
         validator: (telefono){
           String pattern = r'(^(([6-7]){1})?[0-9]{7}$)';
              RegExp r = new RegExp(pattern);
             if (!r.hasMatch(telefono)){
                return 'Teléfono inválido';
              }else{
                return null;
              }
         },
          ),
        );
}

 Widget _nameTextField(String nom, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
         initialValue: nom,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.description, color: Colors.blue,),
         hintText: 'Nombre',
         labelText: 'Nombre del proveedor',
            ),
         onSaved: (d) => _name = d,
         validator: (value){
            if (value.length == 0) { return 'El nombre no puede ir vacío'; 
            }else { return null; }
         },
          ),
        );
}

 Widget _emailTextField(String correo, FocusNode focus){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.emailAddress,
         maxLines: 1,
         initialValue: correo,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.mail, color: Colors.blue,),
         hintText: 'Correo electrónico',
         labelText: 'Correo electrónico',
        ),
         onSaved: (e) => _email = e,
         validator: (value){
            if (value.length == 0) { return 'La existencia no puede ir vacía'; 
            }else { return null; }
         },
          ),
        );
}



_submit(BuildContext context) async {
  final proveedorProvider = Provider.of<ProveedorProvider>(context, listen: false);
  if(formKey.currentState.validate()){
    formKey.currentState.save();
    
    Proveedore p = new Proveedore(
      idProveedor: widget.proveedor.idProveedor,
      name: _name,
      email: _email,
      phone: _phone
    );
    
    bool ans = await proveedorProvider.updateProveedor(p);
     if(ans){
      Fluttertoast.showToast(msg: 'Proveedor actualizado exitosamente', toastLength: Toast.LENGTH_LONG);
    }else{
      Fluttertoast.showToast(msg: 'Ocurrió un problema, inténtalo más tarde', toastLength: Toast.LENGTH_LONG);
    }
    Navigator.of(context).pop();
   
  }
}


}