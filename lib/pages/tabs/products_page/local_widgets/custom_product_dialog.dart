import 'package:cache_image/cache_image.dart';
import 'package:demo/database/database.dart';
import 'package:demo/provider/products_manager_provider.dart';
import 'package:demo/utils/color_to_name_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';


class CustomProductDialog extends StatefulWidget {

  String title;
  String imageUrl;
  List<Colore> colores;

  CustomProductDialog({Key key, this.title, this.imageUrl, this.colores}) : super(key: key);

  @override
  _CustomProductDialogState createState() => _CustomProductDialogState();
}

class _CustomProductDialogState extends State<CustomProductDialog> {
  
  Color currentColor = Colors.limeAccent;
  String _name = '';
  ProductsManager _pManager;
  List<Color> colores_value;
  List<String> names_value;
  
   
  @override
  Widget build(BuildContext context) {
     _pManager = Provider.of<ProductsManager>(context, listen: false);
    colores_value = widget.colores.map((it) => Hexcolor(it.value)).toList();
    //colores_value.map((color) => Hexcolor(color)).toList()
    names_value = widget.colores.map((it) =>  it.name).toList();
    
    return AlertDialog(
      title: Consumer<ProductsManager>(builder: (context, value, child) => Text('${value.color}', textAlign: TextAlign.center,),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  width: 70,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Image(
                      image: CacheImage(widget.imageUrl, duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Icon(Icons.arrow_drop_up),
                    Consumer<ProductsManager>(builder: (context, value, child) => _customBlockPicker()),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
          RaisedButton(onPressed: (){ _pManager.setColorString('asdfa'); }, child: Text('boton'),)
        ],
      ),
    ); 
  }

  void _changeColor(Color color) {
    String colorNuevo = names_value[colores_value.indexOf(color)];
    _pManager.setColorString(colorNuevo);
    _pManager.setCurrentColor(color);
  }


  BlockPicker _customBlockPicker(){
    return BlockPicker(
      //RECIBIR DE LA API
      availableColors: colores_value,
      layoutBuilder: (context, colors, child) => _customLayoutBuilder(context, colors, child),
      itemBuilder: (color, isCurrentColor, changeColor) => _customItemBuilder(color, isCurrentColor, changeColor),
      pickerColor: _pManager.currentColor,
      onColorChanged: _changeColor, 
    );
  }

  Container _customLayoutBuilder(BuildContext context, List<Color> colors, Widget Function(Color) child){
    return Container(
      width: 200,
      height: 200,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 1,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  Widget _customItemBuilder(Color color, bool isCurrentColor, Function changeColor){
    return Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.black),
            borderRadius: BorderRadius.circular(50.0),
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.8),
                offset: Offset(1.0, 2.0),
                blurRadius: 3.0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: changeColor,
              borderRadius: BorderRadius.circular(50.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 210),
                opacity: isCurrentColor ? 1.0 : 0.0,
                child: Icon(
                  Icons.done,
                  color: useWhiteForeground(color) ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      }

}