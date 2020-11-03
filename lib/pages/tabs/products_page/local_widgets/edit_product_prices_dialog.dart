import 'package:demo/database/database.dart';
import 'package:demo/database/dtos/producto_detalle_dto.dart' as dtos;
import 'package:demo/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditPrices extends StatefulWidget {

  final ProductoDetalle productoDetalle;
  final int categoryId;

  EditPrices({Key key, this.productoDetalle, this.categoryId}) : super(key: key);

  @override
  _EditPricesState createState() => _EditPricesState();
}

class _EditPricesState extends State<EditPrices> {

  final formKey = GlobalKey<FormState>();
  String _precioUnitario, _precioDocena, _precioMayorista, _precioYarda, _precioCien, _precio500U, _precioCaja, _precioFardo, _precioRollo, _precioGruesa, _precioMillar, _precioBolsa;


  @override
  void initState() {
    super.initState();
    _setPrices();
  }

  void _setPrices(){
    _precioUnitario = widget.productoDetalle.precioUnitario.toStringAsFixed(2);
    _precioDocena = widget.productoDetalle.precioDocena.toStringAsFixed(2);
    _precioMayorista = widget.productoDetalle.precioMayorista.toStringAsFixed(2);
    _precioYarda = widget.productoDetalle.precioYarda.toStringAsFixed(2);
    _precioCien = widget.productoDetalle.precioCien.toStringAsFixed(2);
    _precio500U = widget.productoDetalle.precio500U.toStringAsFixed(2);
    _precioCaja = widget.productoDetalle.precioCaja.toStringAsFixed(2);
    _precioFardo = widget.productoDetalle.precioFardo.toStringAsFixed(2);
    _precioRollo = widget.productoDetalle.precioRollo.toStringAsFixed(2);
    _precioGruesa = widget.productoDetalle.precioGruesa.toStringAsFixed(2);
    _precioMillar = widget.productoDetalle.precioMillar.toStringAsFixed(2);
    _precioBolsa = widget.productoDetalle.precioBolsa.toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Precios'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: _buildForm(context),
              ),
               actionsPadding: EdgeInsets.symmetric(horizontal: 5),
              actions: [
                _createButton(context, 'Guardar cambios'),
                FlatButton(child: Text('Cerrar'), onPressed: () => Navigator.of(context).pop()),
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

  void _submit(BuildContext context) async {
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    if(formKey.currentState.validate()){
    formKey.currentState.save();
    
    dtos.ProductoDetalle p = new dtos.ProductoDetalle(
      id: widget.productoDetalle.idProductoDetalle,
      precioUnitario: _precioUnitario,
      precioDocena: _precioDocena,
      precioFardo: _precioFardo,
      precioCaja: _precioCaja,
      precioCien: _precioCien,
      precio500U: _precio500U,
      precioBolsa: _precioBolsa,
      precioGruesa: _precioGruesa,
      precioMayorista: _precioMayorista,
      precioMillar: _precioMillar,
      precioYarda: _precioYarda,
      precioRollo: _precioRollo
    );
    
    bool ans = await productProvider.updateProductDetail(p);
     if(ans){
      Fluttertoast.showToast(msg: 'Campos actualizado exitosamente', toastLength: Toast.LENGTH_LONG);
    }else{
      Fluttertoast.showToast(msg: 'Ocurrió un problema, inténtalo más tarde', toastLength: Toast.LENGTH_LONG);
    }
    Navigator.of(context).pop();
    }
  }
        
      Widget _buildForm(BuildContext context) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              if (widget.categoryId == 1 || widget.categoryId == 4 || widget.categoryId == 5 || widget.categoryId == 6) _precioUnitarioTextField(_precioUnitario),
              
              if(widget.categoryId == 3) _precioYardaTextField(_precioYarda),

              if(widget.categoryId == 2 || widget.categoryId == 4 || widget.categoryId == 5)  _precioDocenaTextField(_precioDocena),

              if(widget.categoryId == 2) _precioCienTextField(_precioCien),
              if(widget.categoryId == 2) _precio500TextField(_precio500U),
              if(widget.categoryId == 2) _precioCajaTextField(_precioCaja),
              if(widget.categoryId == 2) _precioFardoTextField(_precioFardo),
              if(widget.categoryId == 2) _precioGruesaTextField(_precioGruesa),
              if(widget.categoryId == 2) _precioMillarTextField(_precioMillar),
              
              if(widget.categoryId == 3) _precioRolloTextField(_precioRollo),

              if(widget.categoryId == 2) _precioBolsaTextField(_precioBolsa),

              _precioMayoristaTextField(_precioMayorista),
             
            ],
          ),
        );
      }


      Widget _precioUnitarioTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Unitario',
              labelText: 'Precio Unitario',
            ),
              onSaved: (d) => _precioUnitario = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

      Widget _precioYardaTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Yarda',
              labelText: 'Precio Yarda',
            ),
              onSaved: (d) => _precioYarda = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

      Widget _precioDocenaTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Docena',
              labelText: 'Precio Docena',
            ),
              onSaved: (d) => _precioDocena = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

       Widget _precioCienTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio 100',
              labelText: 'Precio 100',
            ),
              onSaved: (d) => _precioCien = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

      Widget _precio500TextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio 500',
              labelText: 'Precio 500',
            ),
              onSaved: (d) => _precio500U = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

      Widget _precioCajaTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Caja',
              labelText: 'Precio Caja',
            ),
              onSaved: (d) => _precioCaja = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

       Widget _precioFardoTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Fardo',
              labelText: 'Precio Fardo',
            ),
              onSaved: (d) => _precioFardo = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

       Widget _precioGruesaTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Gruesa',
              labelText: 'Precio Gruesa',
            ),
              onSaved: (d) => _precioGruesa = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

       Widget _precioMillarTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Millar',
              labelText: 'Precio Millar',
            ),
              onSaved: (d) => _precioMillar = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }


      Widget _precioRolloTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Rollo',
              labelText: 'Precio Rollo',
            ),
              onSaved: (d) => _precioRollo = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

       Widget _precioBolsaTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Bolsa',
              labelText: 'Precio Bolsa',
            ),
              onSaved: (d) => _precioBolsa = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }

       Widget _precioMayoristaTextField(String cant){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 1,
              initialValue: cant,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
              icon: Icon(Icons.monetization_on, color: Colors.blue,),
              hintText: 'Precio Mayorista',
              labelText: 'Precio Mayorista',
            ),
              onSaved: (d) => _precioMayorista = d,
              validator: (value){
                  if (value.length == 0) { return 'El precio no puede ir vacía'; 
                  }else { return null; }
              },
                ),
              );
      }








}