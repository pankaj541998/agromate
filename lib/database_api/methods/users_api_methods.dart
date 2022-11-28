import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../url.dart';

class UserApiMethods {
  static Future<List<UserModel>> fetchUsers() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getUsers));
    return compute(_parseUsers, response.body);
  }

  static List<UserModel> _parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  }
}
