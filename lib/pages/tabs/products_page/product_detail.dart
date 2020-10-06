import 'package:flutter/material.dart';
import 'package:cache_image/cache_image.dart';

class ProductDetailPage extends StatelessWidget { 

  final int id;
  
  const ProductDetailPage({this.id});

 @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text("===TODO==="),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image(
                    image: CacheImage("https://pbs.twimg.com/profile_images/993555605078994945/Yr-pWI4G.jpg", duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,               
                children: _productInfoContainer(context)
              ),
            ),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          tooltip: "Edita la información de este producto",
          child: Icon(Icons.edit)
        ),
      );
  }

  List<Widget> _productInfoContainer(BuildContext context){
    return [
      _productInfo("Descripción: ", ""),
      _productInfo("Precio Unitario: ", ""),
      _productInfo("Precio Docena: ", ""),
      _productInfo("Proveedor: ", ""),
      _productInfo("Especificaciones: ", ""),
      _productInfo("Existencias: ", ""),
    ];
  }

  Padding _productInfo(String field, String value){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,),
        child: _productField(field, value),  
      );
  }

  RichText _productField(String field, String value){
    return RichText(
      text: TextSpan(
        text: field,
        style: TextStyle(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(text: value),
        ] 
      )
    );
  }

  /*List<Widget> _showSizesDelegate(){
    return [];
  }*/

}