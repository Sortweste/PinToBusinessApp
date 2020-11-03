import 'package:demo/database/database.dart';
import 'package:demo/provider/clientes_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditCliente extends StatefulWidget {
  
  final Cliente c;

  EditCliente({Key key, @required this.c}) : super(key: key);

  @override
  _EditClienteState createState() => _EditClienteState();
}

class _EditClienteState extends State<EditCliente> {

   final formKey = GlobalKey<FormState>();
  String _nombre, _apellido, _telefono, _email;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
       title: Text('Editar Cliente'),
       content: SingleChildScrollView(
         child: Container(
           width: screen.width,
           child: _buildForm(context, widget.c),
         ),
       ),
       actionsPadding: EdgeInsets.symmetric(horizontal: 5),
       actions: [
         _createButton(context),
         FlatButton(child: Text('Cerrar'), onPressed: () => Navigator.of(context).pop(),),
       ],
    );
  }

  Widget _buildForm(BuildContext context, Cliente c) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 10,),
            _nombreTextField(c.nombre),
            SizedBox(height: 5,),
            _apellidoTextField(c.apellido),
            SizedBox(height: 5,),
            _emailTextField(c.email),
            SizedBox(height: 5,),
            _phoneTextField(c.telefono),
          ],
        ),
      ),
    );
  }

  Widget _createButton(BuildContext context){
    return Container(
        child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text('Guardar cambios'),
        color: Colors.blueGrey,
        onPressed: (){ _submit(context); }
      ),
    );
  }

  Widget _nombreTextField(String code){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.text,
         maxLines: 1,
         initialValue: code,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.people, color: Colors.blue,),
         hintText: 'Nombre',
         labelText: 'Nombre del cliente',
        ),
         onSaved: (d) => _nombre = d,
         validator: (value){
            if (value.length == 0) { return 'El código no puede ir vacía'; 
            }else { return null; }
         },
          ),
        );
}

Widget _apellidoTextField(String code){
   return Container(
     margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
       child: TextFormField(
         keyboardType: TextInputType.text,
         maxLines: 1,
         initialValue: code,
         decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
         icon: Icon(Icons.people, color: Colors.blue,),
         hintText: 'Apellido',
         labelText: 'Apellido del cliente',
        ),
         onSaved: (d) => _apellido = d,
         validator: (value){
            if (value.length == 0) { return 'El código no puede ir vacía'; 
            }else { return null; }
         },
      ),
  );
}

Widget _phoneTextField(String tel){
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
         labelText: 'Teléfono del cliente',
        ),
         onSaved: (d) => _telefono = d,
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

Widget _emailTextField(String correo){
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
            if (!EmailValidator.validate(value)) { return 'El email no puede ir vacío'; 
            }else { return null; }
         },
          ),
        );
}

_submit(BuildContext context) async {
  final clientesProvider = Provider.of<ClientesProvider>(context, listen: false);
  if(formKey.currentState.validate()){
    formKey.currentState.save();
    
    Cliente c = new Cliente(
      idCliente: widget.c.idCliente,
      nombre: _nombre,
      apellido: _apellido,
      telefono: _telefono,
      email: _email,
      vigente: false
    );
    
    bool ans = await clientesProvider.updateCliente(c);
     if(ans){
      Fluttertoast.showToast(msg: 'Cliente creado exitosamente', toastLength: Toast.LENGTH_LONG);
    }else{
      Fluttertoast.showToast(msg: 'Ocurrió un problema, inténtalo más tarde', toastLength: Toast.LENGTH_LONG);
    }
    Navigator.of(context).pop();
   
  }
}









}