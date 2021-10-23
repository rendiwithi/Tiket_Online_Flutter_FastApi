import 'package:flutter/material.dart';
import 'package:tiket_bioskop_online/model/user.dart';
import 'package:tiket_bioskop_online/screen/main_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tiket Bioskop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen());
  }
}
