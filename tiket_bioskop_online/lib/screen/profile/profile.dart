import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:tiket_bioskop_online/model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox("user"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                  child: const Text(
                    "Ada Error Program !!!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              } else {
                var user = Hive.box('user');
                if (user.isNotEmpty) {
                  List<dynamic> u = user.getAt(0);
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(u[0].name,
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () {
                            user.clear();
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(color: Colors.red),
                            child: const Center(
                              child: Text("Log Out",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: TextField(
                            style: const TextStyle(color: Color(0xff777777)),
                            controller: userController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukkan Username anda",
                              hintStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Color(0xff777777),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: TextField(
                            style: const TextStyle(color: Color(0xff777777)),
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukkan Password anda",
                              hintStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Color(0xff777777),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              User.connectToApi(
                                username:
                                    ((userController.text).contains(' ') ||
                                            (userController.text).isEmpty)
                                        ? "a"
                                        : userController.text,
                                password:
                                    ((passwordController.text).contains(' ') ||
                                            (passwordController.text).isEmpty)
                                        ? "a"
                                        : passwordController.text,
                              ).then((value) {
                                // userLogin = value;
                                if (value.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Data Salah ${passwordController.text}");
                                } else {
                                  user.add(value);
                                  setState(() {});
                                }
                              });
                            },
                            child: const Text("Login"),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
