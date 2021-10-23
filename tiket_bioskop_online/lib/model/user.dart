import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:tiket_bioskop_online/constant/api.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String username;
  @HiveField(3)
  String password;
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  // fungsi factory untuk mengambil data json tiap user
  factory User.fromJson(Map<String, dynamic> object) {
    return User(
      id: (object["id"] == null) ? 0 : object["id"],
      name: (object["id"] == null) ? "" : object["name"],
      username: (object["id"] == null) ? "" : object["username"],
      password: (object["id"] == null) ? "" : object["password"],
    );
  }

 static Future<List<User>> connectToApi({
    required String username,
    required String password,
  }) async {
    String apiUrl = "$ip/login/" + username + "/" + password;
    List<User> list = [];

    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    for (var i = 0; i < jsonObject.length; i++) {
      list.add(User.fromJson(jsonObject[i]));
    }

    return list;
  }
}
