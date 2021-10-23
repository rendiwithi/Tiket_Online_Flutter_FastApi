import 'dart:convert';

import 'package:tiket_bioskop_online/constant/api.dart';
import 'package:http/http.dart' as http;

class ScheduleMovie{
  int idSchedule;
  int price;
  String room;
  String day;
  String start;
  ScheduleMovie({
    required this.idSchedule,
    required this.room,
    required this.price,
    required this.day,
    required this.start,
  });

  factory ScheduleMovie.fromJson(Map<String, dynamic> object) {
    return ScheduleMovie(
      idSchedule: object["id_schedule"],
      room: object["room_name"],
      price: object["price"],
      day: object["day"],
      start: object["date_start"]
    );
  }
  static Future<List<ScheduleMovie>> connectToApi({required int id}) async {
    String apiUrl = "$ip/get_schedule/"+id.toString();
    List<ScheduleMovie> schedules = [];

    var apiResult = await http.get(
      Uri.parse(apiUrl),
    );
    var jsonObject = json.decode(apiResult.body);

    for (var i = 0; i < jsonObject.length; i++) {
      schedules.add(ScheduleMovie.fromJson(jsonObject[i]));
    }

    return schedules;
  }
}