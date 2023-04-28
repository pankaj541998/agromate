import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/block.dart';

import 'package:http/http.dart' as http;

import '../url.dart';

class BlockApiMethods {
  //post
  static Future<bool> postBlock({
    required int landholderId,
    required int farmId,
    required String blockName,
    required String blockLatLngs,
  }) async {
    var response = await http.post(
      Uri.parse(ApiUrl.postBlock),
      body: {
        "landholder_id": landholderId.toString(),
        "farm_id": farmId.toString(),
        "block": blockName,
        "block_latlong": blockLatLngs,
      },
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  //get
  static Future<List<BlockModel>> fetchBlocks() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getBlocks));
    return compute(_parseBlocks, response.body);
  }

  static List<BlockModel> _parseBlocks(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed.map<BlockModel>((json) => BlockModel.fromJson(json)).toList();
  }
}
