import 'package:flutter/material.dart';
import 'package:demo/database/database.dart';
import 'package:cache_image/cache_image.dart';

class CustomProductCard extends StatelessWidget {

  final Producto product;
  const CustomProductCard({this.product});


  @override
  Widget build(BuildContext context) {
     List<String> pricesList;
     List<String> pricesDesc;
    switch(product.categoryId){
        case 1:
        case 4: 
        case 5:
        case 6:
                pricesList = ["${product.precioUnitario.toStringAsFixed(2)}", "${product.precioDocena.toStringAsFixed(2)}"];
                pricesDesc = ["Precio c/u:", "Precio docena:"];
                break;
        case 2: pricesList = ["${product.precioCien.toStringAsFixed(2)}", "${product.precio500U.toStringAsFixed(2)}", "${(product.precio500U * 2).toStringAsFixed(2)}"];
                pricesDesc = ["Precio 100/u:", "Precio 500/u:", "Precio 1000/u:"];
                break;
        case 3: pricesList = ["${product.precioYarda.toStringAsFixed(2)}", "${product.precioRollo.toStringAsFixed(2)}"];
                pricesDesc = ["Precio yarda:", "Precio rollo:"];
                break;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5))
      ),
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
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
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,               
                children: _customPricesInfo(context, pricesList, pricesDesc)
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _customPricesInfo(BuildContext context, List<String> prices, List<String> descs){
    List<Widget> productDescription = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,),
        child: Text(product.descripcion, 
          style: Theme.of(context).textTheme.headline5.copyWith(
             fontWeight: FontWeight.bold,
            ),
          ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,),
        child: Text(product.specifications),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,),
        child: Text("Existencia: ${product.existencia.toString()} unidades"),
      ),
    ];

  for(int i=0; i<prices.length; i++)
    productDescription.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,),
        child: RichText(
          text: TextSpan(
            text: descs[i],
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: " \$${prices[i]}", style: TextStyle(fontWeight: FontWeight.bold)),
            ] 
          ),
        )
      ),
    );

  return productDescription;

  }
}