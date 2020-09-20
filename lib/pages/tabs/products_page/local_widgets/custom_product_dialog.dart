import 'package:cache_image/cache_image.dart';
import 'package:demo/utils/color_to_name_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class CustomProductDialog extends StatefulWidget {

  String title;
  String imageUrl;

  CustomProductDialog({Key key, this.title, this.imageUrl}) : super(key: key);

  @override
  _CustomProductDialogState createState() => _CustomProductDialogState();
}

class _CustomProductDialogState extends State<CustomProductDialog> {
  
  Color currentColor = Colors.limeAccent;
  String _name = '';
  
  @override
  Widget build(BuildContext context) {
        return AlertDialog(
          title: Text('$_name', textAlign: TextAlign.center,),
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
                    BlockPicker(
                      //RECIBIR DE LA API
                      availableColors: [Colors.red, Colors.white, Colors.blue, Colors.green, Colors.yellow, Colors.orange],
                      layoutBuilder: (context, colors, child) {
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
                      },
                      itemBuilder: (color, isCurrentColor, changeColor) => customItemBuilder(color, isCurrentColor, changeColor),
                      pickerColor: currentColor,
                      onColorChanged: _changeColor,
              ),
              Icon(Icons.arrow_drop_down),
                  ],
                ),
            ),
          ],
        )
            ],
          ),
      ); 
  }

  void _changeColor(Color color) => setState(() { 
    currentColor = color;
    _name = colors[currentColor.value];
    });

  Widget customItemBuilder(Color color, bool isCurrentColor, Function changeColor){
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