import 'package:flutter/material.dart';

class TextErrorWidget extends StatelessWidget {

  final VoidCallback buttonFunction;

  TextErrorWidget({@required this.buttonFunction});

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.error, size: 64,),
        SizedBox(height: 20,),
        Text('Ocurrió un problema :(', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
        SizedBox(height: 10,),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: RaisedButton(
            child: Text('Cargar de nuevo', 
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
            ),
            onPressed: (){
               buttonFunction();
             }, 
             colorBrightness: Brightness.light, color: Colors.redAccent, highlightColor: Colors.red,)),
      ],
      ),
    );
  }
}