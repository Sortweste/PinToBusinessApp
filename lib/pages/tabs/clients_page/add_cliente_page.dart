import 'package:demo/database/database.dart';
import 'package:demo/provider/clientes_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddCliente extends StatefulWidget {
  AddCliente({Key key}) : super(key: key);

  @override
  _AddClienteState createState() => _AddClienteState();
}

class _AddClienteState extends State<AddCliente> {

  final formKey = GlobalKey<FormState>();
  String _nombre, _apellido, _telefono, _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Cliente'),
      ),
      body: SingleChildScrollView(
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(40),
        child: Form(
        key: formKey,
        child: Column(
          children: [
            Text('Ingrese los campos', style: Theme.of(context).textTheme.headline6,),
            SizedBox(height: 10,),
            _nombreTextField(_nombre),
            SizedBox(height: 5,),
            _apellidoTextField(_apellido),
            SizedBox(height: 5,),
            _emailTextField(_email),
            SizedBox(height: 5,),
            _phoneTextField(_telefono),
            SizedBox(height: 10,),
            _createButton(context),
          ],
        ),
      ),
    );
  }

  Widget _createButton(BuildContext context){
    return Container(
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text('Agregar Producto'),
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
      idCliente: 0,
      nombre: _nombre,
      apellido: _apellido,
      telefono: _telefono,
      email: _email,
      vigente: false
    );
    
    bool ans = await clientesProvider.createCliente(c);
     if(ans){
      Fluttertoast.showToast(msg: 'Cliente creado exitosamente', toastLength: Toast.LENGTH_LONG);
    }else{
      Fluttertoast.showToast(msg: 'Ocurrió un problema, inténtalo más tarde', toastLength: Toast.LENGTH_LONG);
    }
    Navigator.of(context).pop();
   
  }
}












}