import 'package:cache_image/cache_image.dart';
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
  
  @override
  Widget build(BuildContext context) {
        return AlertDialog(
          title: Text('$widget.title', textAlign: TextAlign.center,),
          content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image(
              image: CacheImage(widget.imageUrl, duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
              fit: BoxFit.cover
            ),
            BlockPicker(
              pickerColor: currentColor,
              onColorChanged: _changeColor,
            ),
          ],
        ),
      ); 
  }

  void _changeColor(Color color) => setState(() => currentColor = color);

}