import 'package:demo/database/database.dart';
import 'package:demo/models/productos_categoria_model.dart' as pcat;
import 'package:demo/pages/tabs/sales_page/add_product_to_cart_dialog.dart';
import 'package:demo/provider/cart_provider.dart';
import 'package:demo/provider/products_provider.dart';
import 'package:demo/provider/sales_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class AddSalesPage extends StatefulWidget {
  @override
  _AddSalesPageState createState() => _AddSalesPageState();
}

class _AddSalesPageState extends State<AddSalesPage> {
  final Duration _transition = Duration(milliseconds: 250);

  SalesProvider salesProvider;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final c = Provider.of<CarritoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size.height;
    salesProvider = Provider.of<SalesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Venta'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedPositioned(
                  //key: widget.key,
                  duration: _transition,
                  left: 0,
                  right: 0,
                  top: getTopCategoriesPanel(
                      salesProvider.cartState, MediaQuery.of(context).size),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    height: size - 150,
                    child: Column(
                      children: [
                        _buildProducts(context),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _transition,
                  left: 0,
                  right: 0,
                  top: getTopCartPanel(
                      salesProvider.cartState, MediaQuery.of(context).size),
                  child: Container(
                    height: size,
                    padding: EdgeInsets.only(bottom: 75),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Consumer<SalesProvider>(
                          builder: (context, value, child) => AnimatedBuilder(
                            animation: value,
                            builder: (context, child) => GestureDetector(
                              onVerticalDragUpdate: _update,
                              onTap: _actualizar,
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 36,
                                    ),
                                    Text(
                                      '${salesProvider.carrito.length}',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Expanded(
                                        child: Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 36,
                                    )),
                                    Icon(
                                      Icons.monetization_on,
                                      size: 36,
                                    ),
                                    Text('${salesProvider.getTotalAmount()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 3,
                              child: RaisedButton(
                                onPressed: () {
                                  salesProvider.clearCart();
                                },
                                child: Text('Eliminar todo'),
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: RaisedButton(
                                onPressed: generateInvoice,
                                color: Colors.blueGrey,
                                child: Text('Procesar venta'),
                              ),
                            ),
                          ],
                        ),
                        _buildShoppingCart(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _actualizar() {
    setState(() {});
  }

  void _update(DragUpdateDetails details) {
    if (details.primaryDelta < -5) {
      salesProvider.changeToCart();
    } else if (details.primaryDelta > 5) {
      salesProvider.changeToNormal();
    }
  }

  double getTopCategoriesPanel(CartState cs, Size size) {
    if (cs == CartState.normal) {
      return 10;
    } else {
      return -size.height + 200;
    }
  }

  double getTopCartPanel(CartState cs, Size size) {
    if (cs == CartState.normal) {
      return size.height - 130;
    } else {
      return 0;
    }
  }

  Widget _buildProducts(BuildContext context) {
    final productosProvider = Provider.of<ProductsProvider>(context);
    final dao = Provider.of<ProductosDao>(context);
    return Expanded(
      child: FutureBuilder<List<pcat.ProductosCategoria>>(
        future: productosProvider.getSalesProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${snapshot.data[index].descripcion}'),
                  subtitle: Text('${snapshot.data[index].codigo}'),
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.add_shopping_cart),
                  isThreeLine: false,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) =>
                          AddProductToCart(producto: snapshot.data[index]),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildShoppingCart(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: salesProvider.carrito.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${salesProvider.carrito[index].descripcion}'),
            subtitle:
                Text('Cantidad: ${salesProvider.carrito[index].cantidad}'),
            trailing: Text(
                '\$${salesProvider.carrito[index].precioSeleccionado.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }

  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    //drawFooter(page, pageSize);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get the storage folder location using path_provider package.
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/ReporteVentasAgosto.pdf');
    file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    OpenFile.open('$path/ReporteVentasAgosto.pdf');
  }

//Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(65, 104, 205, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'CUGO#302568', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString('\$' + getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: 2058557939\r\n\r\nDate: ' +
        format.format(DateTime.now());
    final Size contentSize = contentFont.measureString(invoiceNumber);
    const String address =
        'Bill To: \r\n\r\nAbraham Swearegin, \r\n\r\nUnited States, California, San Mateo, \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136';

    /* PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));*/

    return PdfTextElement(text: '', font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            30,
            /*120*/ 60,
            pageSize.width - (contentSize.width + 30),
            /*pageSize.height - 120*/ 0));
  }

//Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));

    //Draw grand total.
    /* page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds.left,
            result.bounds.bottom + 10,
            quantityCellBounds.width,
            quantityCellBounds.height));
    page.graphics.drawString(getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds.width,
            totalPriceCellBounds.height));*/
  }

//Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent =
        '800 Interchange Blvd.\r\n\r\nSuite 2501, Austin, TX 78721\r\n\r\nAny Questions? support@adventure-works.com';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

//Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Id';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Venta';
    headerRow.cells[2].value = 'Precio';
    headerRow.cells[3].value = 'Cantidad';
    headerRow.cells[4].value = 'Total';
    //Add rows
    for (var i = 0; i < salesProvider.carrito.length; i++) {
      addProducts(
          '${salesProvider.carrito[i].codigo}',
          '${salesProvider.carrito[i].descripcion}',
          salesProvider.carrito[i].precioSeleccionado,
          salesProvider.carrito[i].cantidad,
          salesProvider.carrito[i].cantidad *
              salesProvider.carrito[i].precioSeleccionado,
          grid);
    }
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

//Create and row for the grid.
  void addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

//Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value = grid.rows[i].cells[grid.columns.count - 1].value;
      total += double.parse(value);
    }
    return double.parse(salesProvider.getTotalAmount().toString());
  }
}
