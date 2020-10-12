import '../database.dart';

class ProductWithColorsAndSizes{
  final Producto producto;
  final List<ProductColorsResult> colore;
  final List<ProductSizesResult> talla;
  ProductWithColorsAndSizes({this.producto, this.colore, this.talla});
}