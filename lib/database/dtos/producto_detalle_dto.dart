// To parse this JSON data, do
//
//     final productoDetalle = productoDetalleFromJson(jsonString);

import 'dart:convert';

ProductoDetalle productoDetalleFromJson(String str) => ProductoDetalle.fromJson(json.decode(str));

String productoDetalleToJson(ProductoDetalle data) => json.encode(data.toJson());

class ProductoDetalle {
    ProductoDetalle({
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

    factory ProductoDetalle.fromJson(Map<String, dynamic> json) => ProductoDetalle(
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
    };
}
