import 'dart:convert';

import 'package:tiket_bioskop_online/constant/api.dart';
import 'package:http/http.dart' as http;

class SheetModel {
  int id;
  bool sold;
  String name;
  SheetModel({
    required this.id,
    required this.sold,
    required this.name,
  });

  factory SheetModel.fromJson(Map<String, dynamic> object) {
    return SheetModel(
      id: object["id"],
      sold: (object["sold"] == 1) ? true : false,
      name: object["name"],
    );
  }
  static Future<List<SheetModel>> connectToApi({required int id}) async {
    String apiUrl = "$ip/get_sheets/" + id.toString();
    List<SheetModel> sheets = [];

    var apiResult = await http.get(
      Uri.parse(apiUrl),
    );
    var jsonObject = json.decode(apiResult.body);

    for (var i = 0; i < jsonObject.length; i++) {
      sheets.add(SheetModel.fromJson(jsonObject[i]));
    }

    return sheets;
  }
}
