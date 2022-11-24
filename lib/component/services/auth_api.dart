import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

class AuthServices {
  static Future<http.Response> addNewUser(
      Map<String, dynamic> adduserdata) async {
    var body = json.encode(adduserdata);
    var url = Uri.parse(baseURL + 'newuser');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(Map<String, dynamic> data) async {
    var body = data;
    print("body is $body");
    var url = Uri.parse(baseURL + 'test');
    http.Response response = await http.post(
      url,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> changePassword(Map<String, dynamic> data) async {
    var body = data;
    print("api call reached and body $body");
    var url = Uri.parse(baseURL + 'updatepassword');
    http.Response response = await http.post(
      url,
      body: body,
    );
    print(response.body);
    return response;
  }
}
