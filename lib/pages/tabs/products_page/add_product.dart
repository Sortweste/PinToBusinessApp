import 'package:demo/database/database.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:demo/provider/proveedor_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {

  final int categoryId;
  AddProduct({Key key, this.categoryId}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final formKey = GlobalKey<FormState>();
  String _codigo = '';
  String _descripcion = '';
  String _existencia = '';
  String _specification = '';
  List<String> names_value;
  List<int> colores_ids;
  String colorSeleccionado = '1', tallaSeleccionada = '1', proveedorSeleccionado = '1';


  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration.zero, () async {
       final provider = Provider.of<ProveedorProvider>(context, listen: false);
       bool ans = await provider.getAllProveedores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agrega un producto'),
      ),
      body: SingleChildScrollView(
        child: _buildForm(context),
      ),
    );
  }

  Widget _colores(BuildContext context){
    final p = Provider.of<ColoresDao>(context);
    return FutureBuilder<List<Colore>>(
      future: p.getAllColores(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return _crearDropdown(snapshot.data);
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<String>> getOpts(List<Colore> cls) {
        List<DropdownMenuItem<String>> lista = new List();

        cls.forEach((color){
          lista.add(DropdownMenuItem(
            child: Text(color.name),
            value: color.idColor.toString(),
            )
          );
        });
        return lista;
    }

  Widget _crearDropdown(List<Colore> c){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(flex: 2,child: Text('Color')),
            Expanded(
            flex: 10,
            child: 
              DropdownButton(
                hint: Text('Selecciona'),
                value: colorSeleccionado,
                items: getOpts(c),
                onChanged: (opt) {
                  setState(() {
                    colorSeleccionado = opt;
                  });
                }
              ),
            ),
             Expanded(flex: 1,child: IconButton(icon: Icon(Icons.add), onPressed: (){
              Fluttertoast.showToast(msg: 'Agregar color nuevo', toastLength: Toast.LENGTH_LONG);
             })),
          ],
        ),
      );
  }

  Widget _tallas(BuildContext context){
    final p = Provider.of<TallasDao>(context);
    return FutureBuilder<List<Talla>>(
      future: p.getAllTallas(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return _crearTallasDropdown(snapshot.data);
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<String>> getTallasOpts(List<Talla> tls) {
        List<DropdownMenuItem<String>> lista = new List();

        tls.forEach((talla){
          lista.add(DropdownMenuItem(
            child: Text(talla.size),
            value: talla.idTalla.toString(),
            )
          );
        });
        return lista;
    }

  Widget _crearTallasDropdown(List<Talla> c){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(flex: 2,child: Text('Talla')),
            Expanded(
            flex: 9,
            child: 
              DropdownButton(
                hint: Text('Selecciona'),
                value: tallaSeleccionada,
                items: getTallasOpts(c),
                onChanged: (opt) {
                  setState(() {
                    tallaSeleccionada = opt;
                  });
                }
              ),
            ),
            Expanded(flex: 1,child: IconButton(icon: Icon(Icons.add), onPressed: (){
              Fluttertoast.showToast(msg: 'Agregar talla nueva', toastLength: Toast.LENGTH_LONG);
             })),
          ],
        ),
      );
  }


   Widget _proveedores(BuildContext context) {
    final p = Provider.of<ProveedoresDao>(context, listen: false);
    return StreamBuilder<List<Proveedore>>(
      stream: p.watchAllProveedores(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return _crearProveedoresDropdown(snapshot.data);
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<String>> getProveedoresOpts(List<Proveedore> ps) {
        List<DropdownMenuItem<String>> lista = new List();

        ps.forEach((prov){
          lista.add(DropdownMenuItem(
            child: Text(prov.name),
            value: prov.idProveedor.toString(),
            )
          );
        });
        return lista;
    }

  Widget _crearProveedoresDropdown(List<Proveedore> c){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(flex: 2,child: Text('p')),
            Expanded(
            flex: 9,
            child: 
              DropdownButton(
                hint: Text('Selecciona'),
                value: proveedorSeleccionado,
                items: getProveedoresOpts(c),
                onChanged: (opt) {
                  setState(() {
                    proveedorSeleccionado = opt;
                  });
                }
              ),
            ),
            Expanded(flex: 1,child: IconButton(icon: Icon(Icons.add), onPressed: (){
              Fluttertoast.showToast(msg: 'Agregar proveedor nueva', toastLength: Toast.LENGTH_LONG);
             })),
          ],
        ),
      );
  }


   Widget _buildForm(BuildContext context) {
    final focus = FocusNode();
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ingrese los campos', style: Theme.of(context).textTheme.headline6,),
            SizedBox(height: 10,),
            _codigoTextField(_codigo, focus),
            _descripcionTextField(_descripcion, focus),
            _existenciaTextField(_existencia, focus),
            _specificationTextField(_specification, focus),
             SizedBox(height: 20,),
             Text('Color, Talla y Proveedor', style: Theme.of(context).textTheme.headline6,),
              SizedBox(height: 10,),
            _colores(context),
            SizedBox(height: 10,),
            _tallas(context),
             SizedBox(height: 10,),
            _proveedores(context),
            SizedBox(height: 30,),
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
  final productosProvider = Provider.of<ProductsProvider>(context, listen: false);
  if(formKey.currentState.validate()){
    formKey.currentState.save();
    
    Producto p = new Producto(
      idProducto: 0,
      codigo: _codigo,
      categoryId: widget.categoryId,
      descripcion: _descripcion,
      existencia: int.parse(_existencia),
      providerId: int.parse(proveedorSeleccionado),
      specifications: _specification,
    );
    
    bool ans = await productosProvider.createProduct(p, colorSeleccionado, tallaSeleccionada);
     if(ans){
      Fluttertoast.showToast(msg: 'Producto creado exitosamente', toastLength: Toast.LENGTH_LONG);
    }else{
      Fluttertoast.showToast(msg: 'Ocurrió un problema, inténtalo más tarde', toastLength: Toast.LENGTH_LONG);
    }
    Navigator.of(context).pop();
   
  }
}



}