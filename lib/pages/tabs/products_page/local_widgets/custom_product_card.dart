import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {

  //final Product product;
  //const CustomProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("HELLO WORLD")
    /*  child: InkWell(
        onTap: (){},
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image(
                    image: CacheImage("URL", duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),  
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Text(product.descripcion),
                  Text(product.specifications),
                  Text(product.existencia),
                  //Text(product.provider),
                ]
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}