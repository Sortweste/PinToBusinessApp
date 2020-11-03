
import 'package:demo/database/dtos/product_with_colors_and_sizes.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/delete_product_dialog.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/edit_product_dialog.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/edit_product_prices_dialog.dart';
import 'package:demo/pages/tabs/products_page/local_widgets/edit_provider_dialog.dart';
import 'package:demo/provider/product_detail_provider.dart';
import 'package:demo/provider/products_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:demo/database/database.dart';
import 'package:url_launcher/url_launcher.dart';


class ProductDetailPage extends StatefulWidget { 

  final int id;
  final int categoryId;
  final Producto producto;
  
  const ProductDetailPage({this.id, this.producto, this.categoryId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  ScrollController _scrollController;
  Color currentColor = Colors.limeAccent;
  ProductsManager _pManager;
  List<Color> colores_value;
  List<String> names_value;
  List<int> colores_ids;
  bool fondo = false;

 

  scrollHandler(){
    _scrollController.addListener(() {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange){
          Future.delayed(Duration(milliseconds: 375), (){
             Provider.of<ProductDetail>(context, listen: false).setFondo(true);
          });
        } else if  (_scrollController.offset <= _scrollController.position.minScrollExtent && !_scrollController.position.outOfRange) {
           Future.delayed(Duration(milliseconds: 375), () async {
             Provider.of<ProductDetail>(context, listen: false).setFondo(false);
          });
        }
     });
  }
  

  @override
  void initState() { 
    super.initState();
    _scrollController = new ScrollController();
    scrollHandler();
    Future.delayed(Duration.zero, (){
       Provider.of<ProductDetail>(context, listen: false).setFondo(false);
     });
  }



 @override
  Widget build(BuildContext context) { 
    final productsDao = Provider.of<ProductosDao>(context);
   // final productDetail = Provider.of<ProductDetail>(context, listen: false);
    _pManager = Provider.of<ProductsManager>(context, listen: false);
    final h = MediaQuery.of(context).orientation;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: StreamBuilder<List<Producto>>(
            stream: productsDao.watchFindProduct(widget.id),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                 int id = (snapshot.data[0].descripcion  == "No disponible") ? 4 : 0;
                 return (id == 4) ? Text('${snapshot.data[0].codigo}') : Text('${snapshot.data[0].descripcion}') ;
              }else{
                return Container();
              }
            }
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          brightness: Brightness.dark,
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white,),
              onPressed: () {
                showMaterialModalBottomSheet(
                context: context,
                isDismissible: true,
                builder: (context, scrollController) => Container(
                  child: Wrap(
                  children: [
                  ListTile(leading: Icon(Icons.edit), title: Text('Editar Producto'),
                      onTap: (){
                        Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            child: EditProduct(id: widget.id,),
                            barrierDismissible: false,
                          );
                      },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Eliminar Producto'),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => DeleteProduct(producto:  widget.producto,),
                      );
                    },
                  ),

                    ],
                  ),
                ),
              );
             },
            ),
          ],
        ),
        body: StreamBuilder<List<ProductWithColorsAndSizes>>(
          stream: productsDao.watchProductoWithColorsAndSizes(widget.id),
          builder: (context, snapshot) {
            return (!snapshot.hasData) ? Center(child: CircularProgressIndicator(),) : NestedScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                      expandedHeight: (h == Orientation.portrait) ? 250 : 150,
                      backgroundColor: Colors.transparent,
                      pinned: false,
                      floating: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.none,
                        background:  Hero(
                            tag: 'p_image_${widget.id}',
                            child: Image(
                              gaplessPlayback: true,
                            image: CacheImage("https://pbs.twimg.com/profile_images/993555605078994945/Yr-pWI4G.jpg", duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),  
              ],
              body:  _buildDetails(context, snapshot.data[0], productsDao),
            );
          }
        ),
      );
  }

  Widget _buildDetails(BuildContext context, ProductWithColorsAndSizes product, ProductosDao productosDao){
    String name = (product.producto.descripcion == "No disponible") ? product.producto.codigo : product.producto.descripcion;
    colores_value = product.colore.map((e) => Hexcolor(e.value)).toList();
    names_value = product.colore.map((e) => e.name).toList();
    colores_ids = product.colore.map((e) => e.idColor).toList();
    if(colores_value.length > 0 && names_value.length > 0){
      _pManager.setIni(product.colore[0].name,(product.talla.isEmpty) ? '' : product.talla[0].size, Hexcolor(product.colore[0].value), product.colore[0].idColor, (product.talla.isEmpty) ? 1 : product.talla[0].idTalla);
    } else {
      _pManager.setIni('', '', Colors.transparent, 1, 1);
    }
    return SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        _productHeader(name, product),
        SizedBox(height: 10,),
        if(product.producto.categoryId != 3) _selectedColorName(),
        _selectPickerMode(product),       
        SizedBox(height: 10,),
        _sizePicker(product),
        SizedBox(height: 30,),
        Consumer<ProductsManager>(
          builder: (context, value, child) {
            return StreamBuilder<List<ProductoDetalle>>(
                     stream: productosDao.watchProductPrices(product.producto.idProducto, value.colorId, value.tallaId),
                     builder: (BuildContext context, AsyncSnapshot snapshot){
                        return (snapshot.hasData) ? (snapshot.data.isNotEmpty) ? _pricesTable(context, snapshot.data) : _noData(context) : Padding(padding: EdgeInsets.symmetric(vertical: 20) ,child: Center(child: CircularProgressIndicator(),));
                   },
                 );
          }, 
        ),
        StreamBuilder<List<Proveedore>>(
        stream: productosDao.watchProductProveedor(product.producto.providerId),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return (snapshot.hasData) ? _providerFields(context, snapshot.data[0]) : Padding(padding:EdgeInsets.symmetric(vertical: 20) ,child: Center(child: CircularProgressIndicator(),));
        },
          ),
      ],
          ),
    );
  }

  Widget _noData(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
       width: size.width,
       decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
       ),
       child: Text('No disponible', style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white), textAlign: TextAlign.center,),
    );
  }

  Widget _selectPickerMode(ProductWithColorsAndSizes product){
      return (product.producto.categoryId != 3) ?  _colorPicker() :  _crearDropdown();
  }

  List<DropdownMenuItem<String>> getOpts() {
        List<DropdownMenuItem<String>> lista = new List();

        names_value.forEach((color){
          lista.add(DropdownMenuItem(
            child: Text(color),
            value: color,
            )
          );
        });
        return lista;
    }

  Widget _crearDropdown(){
    return Consumer<ProductsManager>(
      builder:(context, value, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 2,child: Icon(Icons.select_all)),
            Expanded(
            flex: 8,
            child: 
              DropdownButton(
                value: value.color,
                items: getOpts(),
                onChanged: (opt) {
                    int col = colores_ids[names_value.indexOf(opt)];
                    value.setColorString(opt);
                    value.setColorId(col);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pricesTable(BuildContext context,List<ProductoDetalle> precios){
      final size = MediaQuery.of(context).size;
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Text('Tabla de precios', 
                    style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white), textAlign: TextAlign.center,
                ),
                  ),
                 Expanded(
                   flex: 2,
                      child: FlatButton(
                      onPressed: (){
                         showDialog(
                            context: context,
                            child: EditPrices(productoDetalle: precios[0], categoryId: widget.categoryId,),
                            barrierDismissible: true,
                          );
                      },
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                 ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            if(widget.categoryId == 1 || widget.categoryId == 4 || widget.categoryId == 5 || widget.categoryId == 6) priceField(context, 'Precio unitario', precios[0].precioUnitario),
            if(widget.categoryId == 3) priceField(context, 'Precio yarda', precios[0].precioYarda),
            if((widget.categoryId == 2 || widget.categoryId == 4 ||  widget.categoryId == 5) && precios[0].precioDocena != 0) priceField(context, 'Precio docena', precios[0].precioDocena),
           if(widget.categoryId == 2 && precios[0].precioCien != 0) priceField(context, 'Precio 100', precios[0].precioCien),
           if(widget.categoryId == 2 && precios[0].precio500U != 0) priceField(context, 'Precio 500', precios[0].precio500U),
           if(widget.categoryId == 2 && precios[0].precioCaja != 0) priceField(context, 'Precio caja', precios[0].precioCaja),
           if(widget.categoryId == 2 && precios[0].precioFardo != 0) priceField(context, 'Precio fardo', precios[0].precioFardo),
           if(widget.categoryId == 3) priceField(context, 'Precio rollo', precios[0].precioRollo),
           if(widget.categoryId == 2 && precios[0].precioGruesa != 0) priceField(context, 'Precio gruesa', precios[0].precioGruesa),
           if(widget.categoryId == 2 && precios[0].precioMillar != 0) priceField(context, 'Precio millar', precios[0].precioMillar),
           if(widget.categoryId == 2 && precios[0].precioBolsa != 0) priceField(context, 'Precio bolsa', precios[0].precioBolsa),
            if(precios[0].precioMayorista != 0) priceField(context, 'Precio mayorista', precios[0].precioMayorista),
           
          ],
        ),
      );
  }

  Widget priceField(BuildContext context, String name, double price){
  final size = MediaQuery.of(context).size;
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      Expanded(flex: 4, child: Text(name, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center,),),
      SizedBox(width: 20,),
      Expanded(flex: 2, child: Text('\$ ${price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.start,)),
    ],
  );
}

  Widget _providerFields(BuildContext context, Proveedore proveedor){
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            decoration: BoxDecoration(
               color: Theme.of(context).primaryColor,
               borderRadius: BorderRadius.circular(10),
            ),
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 0), 
            margin: EdgeInsets.symmetric(horizontal: 20), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: Text('Proveedor: ${proveedor.name}',style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white, fontSize: 16) ,textAlign: TextAlign.center,),),
                 Expanded(
                   flex: 3,
                      child: FlatButton(
                      onPressed: (){
                         showDialog(
                            context: context,
                            child: EditProvider(proveedor: proveedor,),
                            barrierDismissible: false,
                          );
                      },
                      child: Icon(Icons.edit, color: Colors.white,),
                    ),
                 ),
              ],
            ),),
        SizedBox(height: 10,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 40),child: InkWell(
          onTap: () async {
            var url = 'tel:+503 ${proveedor.phone.toString()}';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
          child: providerData(context, Icons.phone, proveedor.phone))),
         SizedBox(height: 10,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 40),child: InkWell(
          onTap: () async {
            var url = 'mailto: ${proveedor.email}';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: providerData(context, Icons.mail, proveedor.email))),
      ],
    );
  }

  Widget providerData(BuildContext context, IconData icono, String text){
  final size = MediaQuery.of(context).size;
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      Icon(icono,size: 28, color: Colors.blue,),
      SizedBox(width: 20,),
      Container(
        width: size.width*0.5,
        child: Text(text, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,))
    ],
  );
}

  Row _sizePicker(ProductWithColorsAndSizes product) {
    List tallas = new List<ProductSizesResult>();
    if(product.producto.categoryId == 3){
       tallas.add(product.talla[0]);
    }else{
      tallas.addAll(product.talla);
    }
    return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            Expanded(
                flex: 10,
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Consumer<ProductsManager>(
                  builder: (context, value, child) => (product.talla.length > 0) ? _customSizePicker(tallas) : Center(child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator()),)
                )
              ),
            ),
            SizedBox(width: 10,),
          ],
        );
  }

  Row _colorPicker() {
    return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: Icon(Icons.chevron_left)
            ),
            Expanded(
                flex: 10,
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: (colores_value.length == 0) ? Center(child: CircularProgressIndicator(),) : _customBlockPicker()
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.chevron_right)
            ),
            SizedBox(width: 10,),
          ],
        );
  }

  Consumer<ProductsManager> _selectedColorName() {
    return Consumer<ProductsManager>(
          builder: (context, value, child) => Container(
            width: MediaQuery.of(context).size.width,
            //color: value.currentColor,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text('Color:  ${value.color}', style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 16), textAlign: TextAlign.start,)
          ),
        );
  }

  Consumer<ProductDetail> _productHeader(String name, ProductWithColorsAndSizes product) {
    return Consumer<ProductDetail>(
            builder: (context, value, child) => Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                 padding: EdgeInsets.only(left: (value.fondo()) ? 20 : 0, top: (value.fondo()) ? 10 : 0), 
                 child: AnimatedOpacity(
                   opacity: (value.fondo()) ? 1.0 : 0.0,
                   duration: Duration(milliseconds: 250),
                   curve: Curves.bounceIn,
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                     child: Image(
                       width: (value.fondo()) ? 75 : 0,
                        gaplessPlayback: true,
                      image: CacheImage("https://pbs.twimg.com/profile_images/993555605078994945/Yr-pWI4G.jpg", duration: Duration(seconds: 2), durationExpiration: Duration(seconds: 10)),
                      fit: BoxFit.cover,
                    ),
                   ),
                 )
              ),
               Expanded(
                 flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                       padding: EdgeInsets.only(left: 20,right: 20,top: 5), 
                       child: Hero(tag: 'p_name_${widget.id}' ,child: Text('$name', style: Theme.of(context).primaryTextTheme.headline5.copyWith(
                         color: Theme.of(context).textTheme.headline5.color,
                      fontWeight: FontWeight.w500),)),
                    ),
                     Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), 
                        child: Text('${product.producto.specifications}', style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(
                          color: Theme.of(context).textTheme.subtitle2.color,
                          fontWeight: FontWeight.w500),),
                     ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), 
                        child: Text('${product.producto.existencia} unidades disponibles', style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(fontWeight: FontWeight.w500, 
                        color: Theme.of(context).textTheme.subtitle1.color,
                        fontSize: 16),),
                     )
                  ],
                ),
              ),           
            ],
          ),
        );
  }

  void _changeColor(Color color) {
    String colorNuevo = names_value[colores_value.indexOf(color)];
    _pManager.setColorString(colorNuevo);
    _pManager.setCurrentColor(color);
    _pManager.setColorId(colores_ids[colores_value.indexOf(color)]);
  }


  BlockPicker _customBlockPicker(){
    return BlockPicker(
      availableColors: colores_value,
      layoutBuilder: (context, colors, child) => _customLayoutBuilder(context, colors, child),
      itemBuilder: (color, isCurrentColor, changeColor) => _customItemBuilder(color, isCurrentColor, changeColor),
      pickerColor: _pManager.currentColor,
      onColorChanged: _changeColor, 
    );
  }

  Container _customLayoutBuilder(BuildContext context, List<Color> colors, Widget Function(Color) child){
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: 50,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        physics: BouncingScrollPhysics(),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: (colors.length == 0) ? <Widget>[] : colors.map((Color color) => child(color)).toList(),
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

    Widget _customSizePicker(List<ProductSizesResult> sizes){
      return SizedBox(
          height: 50.0,
          child:  Row(   
            crossAxisAlignment: CrossAxisAlignment.center,         
            children: [
            Icon(Icons.arrow_left),
            Expanded(
              child: _customSizedContainer(sizes),
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      );
    }

    Widget _customSizedContainer(List<ProductSizesResult> sizes){
      return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: sizes.length,
        itemBuilder: (BuildContext context, int index) => _customSizedContainerItem(context, sizes, index)
      );
    }

    Widget _customSizedContainerItem(BuildContext context,List<ProductSizesResult> sizes,int index){ 
      return 
      InkWell(
        onTap: (){
          _pManager.setSizeId(sizes[index].idTalla);
          _pManager.setSelectedSize(sizes[index].size);},
        child: 
          Container(
          width: 80,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: (_pManager.selectedSize == sizes[index].size ? Colors.brown : Colors.white), 
            border: Border.all(width:  (_pManager.selectedSize == sizes[index].size ? 2 : 0.5)),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: Text(sizes[index].size, 
              textAlign: TextAlign.center, 
              style: TextStyle(
                color: (_pManager.selectedSize == sizes[index].size ? Colors.white : Colors.black),
                fontSize: 16
              ),
            )
          ),
        )
      );
    }

  
}