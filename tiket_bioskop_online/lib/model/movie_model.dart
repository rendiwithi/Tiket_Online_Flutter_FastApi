import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tiket_bioskop_online/constant/api.dart';

class Movie {
  // persiapan data yang akan di ambil
  int id;
  String title;
  String desc;
  String imgUrl;
  int rate;
  Movie({
    required this.id,
    required this.title,
    required this.desc,
    required this.imgUrl,
    required this.rate,
  });

  // fungsi factory untuk mengambil data json tiap user
  factory Movie.fromJson(Map<String, dynamic> object) {
    return Movie(
      id: object["id"],
      title: object["name"],
      desc: object["description"],
      imgUrl: object["imgUrl"],
      rate: object["rating"],
    );
  }

  static Future<List<Movie>> connectToApi() async {
    String apiUrl = "$ip/movie/list/";
    List<Movie> movie = [];

    var apiResult = await http.get(
      Uri.parse(apiUrl),
    );
    var jsonObject = json.decode(apiResult.body);

    for (var i = 0; i < jsonObject.length; i++) {
      movie.add(Movie.fromJson(jsonObject[i]));
    }

    return movie;
  }
}