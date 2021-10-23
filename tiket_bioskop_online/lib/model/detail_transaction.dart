import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tiket_bioskop_online/constant/api.dart';

class DetailTransaction {
  // persiapan data yang akan di ambil
  int idSchedule;
  int idSheet;
  int idTransaction;
  int price;
  String movieTitle;
  String date;
  String imgUrl;
  String codeSheet;
  bool isPaid;
  DetailTransaction({
    required this.idSchedule,
    required this.idSheet,
    required this.idTransaction,
    required this.price,
    required this.codeSheet,
    required this.imgUrl,
    required this.movieTitle,
    required this.date,
    required this.isPaid,
  });

  // fungsi factory untuk mengambil data json tiap user
  factory DetailTransaction.fromJson(Map<String, dynamic> object) {
    return DetailTransaction(
      idTransaction: object["id_transaction"],
      idSchedule: object["id_schedule"],
      idSheet: object["id_sheet"],
      price: object["price"],
      codeSheet: object["code_sheet"],
      imgUrl:  object["imgUrl"],
      movieTitle: object["movie_title"],
      date: object["date_start"],
      isPaid: (object["paid"]==1)?true:false,
    );
  }

  static Future<List<DetailTransaction>> connectToApi({required int id}) async {
    String apiUrl = "$ip/detail/transaction/"+id.toString();
    List<DetailTransaction> list = [];

    var apiResult = await http.get(
      Uri.parse(apiUrl),
    );
    var jsonObject = json.decode(apiResult.body);
    for (var i = 0; i < jsonObject.length; i++) {
      list.add(DetailTransaction.fromJson(jsonObject[i]));
    }

    return list;
  }
}