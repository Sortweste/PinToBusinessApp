import 'dart:convert';

import 'package:demo/database/database.dart';
import 'package:demo/models/productos_categoria_model.dart' as PC;
import 'package:demo/provider/cart_provider.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:demo/provider/sales_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddProductToCart extends StatefulWidget {
  final PC.ProductosCategoria producto;
  AddProductToCart({key, this.producto}) : super(key: key);

  @override
  _AddProductToCartState createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {
  final formKey = GlobalKey<FormState>();
  String _codigo;
  String _descripcion;
  String _existencia;
  String _specification;
  List<String> names_value;
  List<int> colores_ids;
  String colorSeleccionado, tallaSeleccionada;
  double precioSeleccionado;

  @override
  void initState() {
    super.initState();
    if (widget.producto.cantidad == null) {
      widget.producto.cantidad = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Agregar al carrito'),
      content: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
            child: _buildForm(context),
          ),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 5),
      actions: [
        _createButton(context),
        FlatButton(
          child: Text('Cerrar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _colores(BuildContext context) {
    final p = Provider.of<ColoresDao>(context);
    return FutureBuilder<List<AllProductColorsResult>>(
      future: p.allProductColors(widget.producto.id),
      builder: (text, snapshot) {
        if (snapshot.hasData) {
          return _crearDropdown(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<String>> getOpts(List<AllProductColorsResult> cls) {
    List<DropdownMenuItem<String>> lista = new List();

    cls.forEach((color) {
      lista.add(DropdownMenuItem(
        child: Text(color.name),
        value: color.idColor.toString(),
      ));
    });
    return lista;
  }

  Widget _crearDropdown(List<AllProductColorsResult> c) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButton(
          isExpanded: true,
          hint: Text('Selecciona un Color'),
          value: colorSeleccionado,
          items: getOpts(c),
          onChanged: (opt) {
            setState(() {
              colorSeleccionado = opt;
            });
          }),
    );
  }

  Widget _tallas(BuildContext context) {
    final p = Provider.of<TallasDao>(context);
    return _crearTallasDropdown(widget.producto.sizes);
  }

  List<DropdownMenuItem<String>> getTallasOpts(List<PC.Size> tls) {
    List<DropdownMenuItem<String>> lista = new List();
    List tallas = tls
        .map((element) {
          return element.size;
        })
        .toSet()
        .toList();
    tallas.toSet().toList().forEach((talla) {
      lista.add(DropdownMenuItem(
        child: Text(talla.toString()),
        value: tls
            .where((element) => element.size == talla)
            .toList()[0]
            .id
            .toString(),
      ));
    });
    return lista;
  }

  Widget _crearTallasDropdown(List<PC.Size> c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: DropdownButton(
                isExpanded: true,
                hint: Text('Selecciona una Talla'),
                value: tallaSeleccionada,
                items: getTallasOpts(c),
                onChanged: (opt) {
                  setState(() {
                    tallaSeleccionada = opt;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _precios(BuildContext context) {
    final p = Provider.of<ProductosDao>(context, listen: false);
    return StreamBuilder<List<ProductoDetalle>>(
      stream: p.watchProductPrices(widget.producto.id,
          int.parse(colorSeleccionado), int.parse(tallaSeleccionada)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _crearPriceDropdown(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<double>> getPriceOpts(List<ProductoDetalle> ps) {
    List<DropdownMenuItem<double>> lista = new List();
    print(ps);
    final List datos = new List();
    final precios = ps[0].toJson();
    precios.keys.forEach((element) {
      if (double.parse(precios[element].toString()) > 0) {
        datos.add([element, precios[element]]);
      }
    });
    print(datos);

    datos.sublist(4).forEach((prov) {
      lista.add(DropdownMenuItem(
        child: Text(
            '${prov[0]} \$${double.parse(prov[1].toString()).toStringAsFixed(2)}'),
        value: double.parse(prov[1].toString()),
      ));
    });
    return lista;
  }

  Widget _crearPriceDropdown(List<ProductoDetalle> c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: DropdownButton(
                hint: Text('Selecciona'),
                value: precioSeleccionado,
                items: getPriceOpts(c),
                onChanged: (opt) {
                  setState(() {
                    precioSeleccionado = opt;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final focus = FocusNode();
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _existenciaTextField(widget.producto.cantidad.toString(), focus),
          SizedBox(
            height: 10,
          ),
          Text('Color'),
          _colores(context),
          SizedBox(
            height: 10,
          ),
          Text('Talla'),
          _tallas(context),
          SizedBox(
            height: 10,
          ),
          (colorSeleccionado != null && tallaSeleccionada != null)
              ? _precios(context)
              : Container(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return Container(
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text('Agregar Producto'),
          color: Colors.blueGrey,
          onPressed: () {
            _submit(context);
          }),
    );
  }

  Widget _existenciaTextField(String cant, FocusNode focus) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        initialValue: cant,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          icon: Icon(
            Icons.queue,
            color: Colors.blue,
          ),
          hintText: 'Cantidad',
          labelText: 'Cantidad',
          //counterText: snapshot.data,
          //errorText: snapshot.error,
        ),
        onSaved: (d) => _existencia = d,
        validator: (value) {
          if (value.length == 0) {
            return 'La cantidad no puede ir vacía';
          } else {
            return null;
          }
        },
      ),
    );
  }

  _submit(BuildContext context) async {
    final carrito = Provider.of<SalesProvider>(context, listen: false);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.producto.colorId = int.parse(colorSeleccionado);
      widget.producto.precioSeleccionado =
          double.parse(precioSeleccionado.toString());
      widget.producto.tallaId = int.parse(tallaSeleccionada);
      widget.producto.cantidad = int.parse(_existencia);
      carrito.carrito.add(widget.producto);

      // print('${colorSeleccionado} ${tallaSeleccionada} ${_existencia}');
      Navigator.pop(context);
    }
  }
}
