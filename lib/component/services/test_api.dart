import 'package:http/http.dart' as http;

import '../services/globals.dart';

class Testapi {
  Testapi();

  Future<http.Response> testAppAPI(Map<String, dynamic> data) async {
    var body = data;
    print("body is $body");
    var url = Uri.parse(baseURL + 'test');
    http.Response response = await http.post(
      url,
      //  headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
}
