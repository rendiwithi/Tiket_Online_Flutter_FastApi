import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tiket_bioskop_online/constant/api.dart';

class AddTransaction {
  int status;
  AddTransaction({
    required this.status,
  });

  // fungsi factory untuk mengambil data json tiap AddTransaction
  factory AddTransaction.fromJson(Map<String, dynamic> object) {
    return AddTransaction(status: object["status"]);
  }

  static Future<AddTransaction> connectToApi({
    required int idUser,
    required int idSchedule,
    required int idDetailRoom,
  }) async {
    String apiUrl = "$ip/detail_transaction/create/" +
        idUser.toString() +
        "/" +
        idSchedule.toString() +
        "/" +
        idDetailRoom.toString();
    var apiResult = await http.post(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    return AddTransaction.fromJson(jsonObject);
  }
}
