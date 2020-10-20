import 'package:demo/pages/tabs/products_page/product_detail.dart';
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
    /*switch(product.categoryId){
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
    }*/

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5))
      ),
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
         // final f = Provider.of<ProductDetail>(context, listen: false);
         // f.reset();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(id: product.idProducto,),));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 10, top: 0),
                  child: Hero(
                      tag: 'p_image_${product.idProducto}',
                      child: Image(
                      gaplessPlayback: true,
                      image: CacheImage("https://pbs.twimg.com/profile_images/993555605078994945/Yr-pWI4G.jpg", 
                      duration: Duration(seconds: 1), durationExpiration: Duration(seconds: 10)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),  
            Expanded(
              flex: 6,
              child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,               
              children: _customPricesInfo(context, pricesList, pricesDesc),
                ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _customPricesInfo(BuildContext context, List<String> prices, List<String> descs){
    final name = (product.descripcion == "No disponible") ? product.codigo : product.descripcion;
    List<Widget> productDescription = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Hero(
            tag: 'p_name_${product.idProducto}',
            child: Text(name, 
            style: Theme.of(context).textTheme.headline5.copyWith(
               fontWeight: FontWeight.bold,
              ),
            ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Text(
          product.codigo,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      SizedBox(height: 24.0,),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          "Especificación: ${product.specifications} unidades",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ];

 /* for(int i=0; i<prices.length; i++)
    productDescription.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0,),
        child: RichText(
          text: TextSpan(
            text: descs[i],
            style: Theme.of(context).textTheme.bodyText1,
            children: <TextSpan>[
              TextSpan(text: " \$${prices[i]}", style: TextStyle(fontWeight: FontWeight.bold)),
            ] 
          ),
        )
      ),
    );*/

  return productDescription;

  }
}