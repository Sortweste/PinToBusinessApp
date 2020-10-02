/*import 'dart:convert

import '../database.dart';';

class ListColorConverter extends TypeConverter<List<Colore>, String> {
  const ListColorConverter();
  
  @override
  List<Colore> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Colore.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(List<Colore> value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }

}*/