import 'dart:convert';

import 'package:http/http.dart' as http;

class AgroApiMethods {
  static Future<bool> postPolygon({
  required String name,
  required List coordinates,
}) async {
  var response = await http.post(
    Uri.parse(
        "http://api.agromonitoring.com/agro/1.0/polygons?appid=7510499ac90659358679969d8c096374"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      "name": name,
      "geo_json": {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "Polygon",
          "coordinates": [coordinates]
        }
      }
    }),
  );
  if(response.statusCode == 201) return true;
  return false;
}
}