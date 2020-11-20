// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
    UserProfile({
        this.id,
        this.username,
        this.passwordDigest,
        this.nombre,
        this.apellido,
        this.email,
        this.telefono,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String username;
    String passwordDigest;
    String nombre;
    String apellido;
    String email;
    String telefono;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        username: json["username"],
        passwordDigest: json["password_digest"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        telefono: json["telefono"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password_digest": passwordDigest,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "telefono": telefono,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
