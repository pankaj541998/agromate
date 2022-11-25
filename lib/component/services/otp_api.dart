import 'package:http/http.dart' as http;

import 'globals.dart';

class OTPServices {
  Future<http.Response> otp(Map<String, dynamic> adduserdata) async {
    print("api called");
    var body = adduserdata;
    var url = Uri.parse('${baseURL}otp');
    http.Response response = await http.post(
      url,
      body: body,
    );
    print(response.body);
    return response;
  }

  Future<http.Response> verifyOTP(Map<String, dynamic> data) async {
    var body = data;
    print("body is $body");
    var url = Uri.parse('${baseURL}verifyotp');
    http.Response response = await http.post(
      url,
      body: body,
    );
    print(response.body);
    return response;
  }
}
