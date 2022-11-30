import 'package:http/http.dart' as http;

import 'constants.dart';

class Registerapi {
  Future editDataByUsername(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = http.Client();

    http.Response response = await _chuckerHttpClient.post(
      Uri.parse(
        ApiConstant.registerAPI,
      ),
      body: updata,
      // headers: {"Accept": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else {
      return response;
    }
  }

  Future register(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = http.Client();

    http.Response response = await _chuckerHttpClient.post(
      Uri.parse(
        "",
      ),
      body: updata,
      headers: {"Accept": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // final body = json.decode(response.body);
      //  PostByBrandModel brandPosts = PostByBrandModel.fromJson(body);
      print(response.body);
      return null;
    } else
      throw (Exception("Brand Search Error"));
  }
}
