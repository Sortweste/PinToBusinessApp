// To parse this JSON data, do
//
//     final productosCategoria = productosCategoriaFromJson(jsonString);

import 'dart:convert';

List<ProductosCategoria> productosCategoriaFromJson(String str) =>
    List<ProductosCategoria>.from(
        json.decode(str).map((x) => ProductosCategoria.fromJson(x)));

String productosCategoriaToJson(List<ProductosCategoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductosCategoria {
  ProductosCategoria({
    this.id,
    this.codigo,
    this.descripcion,
    this.existencia,
    this.specification,
    this.imagen,
    this.provider,
    this.category,
    this.colors,
    this.sizes,
    this.productoColors,
    this.productoSizes,
    this.productDetails,
  });

  int id;
  String codigo;
  String descripcion;
  int existencia;
  String specification;
  dynamic imagen;
  Provider provider;
  Category category;
  List<Color> colors;
  List<Size> sizes;
  List<ProductoColor> productoColors;
  List<ProductoSize> productoSizes;
  List<ProductDetail> productDetails;
  double precioSeleccionado;
  int cantidad;
  int colorId;
  int tallaId;

  factory ProductosCategoria.fromJson(Map<String, dynamic> json) =>
      ProductosCategoria(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        existencia: json["existencia"],
        specification:
            json["specification"] == null ? null : json["specification"],
        imagen: json["imagen"],
        provider: Provider.fromJson(json["provider"]),
        category: Category.fromJson(json["category"]),
        colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
        sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
        productoColors: List<ProductoColor>.from(
            json["producto_colors"].map((x) => ProductoColor.fromJson(x))),
        productoSizes: List<ProductoSize>.from(
            json["producto_sizes"].map((x) => ProductoSize.fromJson(x))),
        productDetails: List<ProductDetail>.from(
            json["product_details"].map((x) => ProductDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "existencia": existencia,
        "specification": specification == null ? null : specification,
        "imagen": imagen,
        "provider": provider.toJson(),
        "category": category.toJson(),
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
        "producto_colors":
            List<dynamic>.from(productoColors.map((x) => x.toJson())),
        "producto_sizes":
            List<dynamic>.from(productoSizes.map((x) => x.toJson())),
        "product_details":
            List<dynamic>.from(productDetails.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.imageUrl,
  });

  int id;
  CategoryName name;
  String imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: categoryNameValues.map[json["name"]],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": categoryNameValues.reverse[name],
        "image_url": imageUrl,
      };
}

enum CategoryName { HERRAJES }

final categoryNameValues = EnumValues({"Herrajes": CategoryName.HERRAJES});

class Color {
  Color({
    this.id,
    this.name,
    this.value,
  });

  int id;
  ColorName name;
  Value value;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        id: json["id"],
        name: colorNameValues.map[json["name"]],
        value: valueValues.map[json["value"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": colorNameValues.reverse[name],
        "value": valueValues.reverse[value],
      };
}

enum ColorName { NICKEL }

final colorNameValues = EnumValues({"Nickel": ColorName.NICKEL});

enum Value { THE_7_A7675 }

final valueValues = EnumValues({"#7A7675": Value.THE_7_A7675});

class ProductDetail {
  ProductDetail({
    this.id,
    this.productId,
    this.colorId,
    this.sizeId,
    this.precioUnitario,
    this.precioDocena,
    this.precioMayorista,
    this.precioYarda,
    this.precioCien,
    this.precio500U,
    this.precioCaja,
    this.precioFardo,
    this.precioRollo,
    this.precioGruesa,
    this.precioMillar,
    this.precioBolsa,
    this.existencia,
    this.imagen,
  });

  int id;
  int productId;
  int colorId;
  int sizeId;
  String precioUnitario;
  String precioDocena;
  String precioMayorista;
  dynamic precioYarda;
  String precioCien;
  String precio500U;
  dynamic precioCaja;
  String precioFardo;
  dynamic precioRollo;
  String precioGruesa;
  String precioMillar;
  String precioBolsa;
  int existencia;
  dynamic imagen;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        productId: json["product_id"],
        colorId: json["color_id"],
        sizeId: json["size_id"],
        precioUnitario: json["precioUnitario"],
        precioDocena: json["precioDocena"],
        precioMayorista: json["precioMayorista"],
        precioYarda: json["precioYarda"],
        precioCien: json["precioCien"],
        precio500U: json["precio500U"],
        precioCaja: json["precioCaja"],
        precioFardo: json["precioFardo"],
        precioRollo: json["precioRollo"],
        precioGruesa: json["precioGruesa"],
        precioMillar: json["precioMillar"],
        precioBolsa: json["precioBolsa"],
        existencia: json["existencia"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "color_id": colorId,
        "size_id": sizeId,
        "precioUnitario": precioUnitario,
        "precioDocena": precioDocena,
        "precioMayorista": precioMayorista,
        "precioYarda": precioYarda,
        "precioCien": precioCien,
        "precio500U": precio500U,
        "precioCaja": precioCaja,
        "precioFardo": precioFardo,
        "precioRollo": precioRollo,
        "precioGruesa": precioGruesa,
        "precioMillar": precioMillar,
        "precioBolsa": precioBolsa,
        "existencia": existencia,
        "imagen": imagen,
      };
}

class ProductoColor {
  ProductoColor({
    this.id,
    this.productId,
    this.colorId,
  });

  int id;
  int productId;
  int colorId;

  factory ProductoColor.fromJson(Map<String, dynamic> json) => ProductoColor(
        id: json["id"],
        productId: json["product_id"],
        colorId: json["color_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "color_id": colorId,
      };
}

class ProductoSize {
  ProductoSize({
    this.id,
    this.productId,
    this.sizeId,
  });

  int id;
  int productId;
  int sizeId;

  factory ProductoSize.fromJson(Map<String, dynamic> json) => ProductoSize(
        id: json["id"],
        productId: json["product_id"],
        sizeId: json["size_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "size_id": sizeId,
      };
}

class Provider {
  Provider({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  int id;
  ProviderName name;
  String phone;
  Email email;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: providerNameValues.map[json["name"]],
        phone: json["phone"],
        email: emailValues.map[json["email"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": providerNameValues.reverse[name],
        "phone": phone,
        "email": emailValues.reverse[email],
      };
}

enum Email { CUGO_GMAIL_COM }

final emailValues = EnumValues({"cugo@gmail.com": Email.CUGO_GMAIL_COM});

enum ProviderName { PROVIDER_1 }

final providerNameValues = EnumValues({"provider 1": ProviderName.PROVIDER_1});

class Size {
  Size({
    this.id,
    this.size,
  });

  int id;
  String size;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
