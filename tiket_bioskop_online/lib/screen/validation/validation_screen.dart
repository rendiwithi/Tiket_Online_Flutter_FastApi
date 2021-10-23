import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiket_bioskop_online/main.dart';
import 'package:tiket_bioskop_online/model/add_transaction.dart';
import 'package:tiket_bioskop_online/model/movie_model.dart';
import 'package:tiket_bioskop_online/model/schedule_id.dart';
import 'package:url_launcher/url_launcher.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({
    Key? key,
    required this.listSheet,
    required this.movie,
    required this.schedule,
    required this.idUser,
  }) : super(key: key);
  final List<int> listSheet;
  final ScheduleMovie schedule;
  final Movie movie;
  final int idUser;
  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  launchURL({required String url}) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    Widget details({required String title, required String data}) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(data),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("pesan sekarang"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              details(title: "Judul Film", data: widget.movie.title),
              details(title: "nomor kursi", data: widget.listSheet.join(',')),
              const Center(child: Text("Harga tiket")),
              details(
                  title: "100000/tiket",
                  data:
                      "Rp.${widget.listSheet.length * widget.schedule.price}"),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    "lakukan pembayaran Rp.${widget.listSheet.length * widget.schedule.price}\nke rekening 968430",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    "Lalu Konfirmasi pemabayaran\ndi kasir / via wa di bawah",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  onPressed: () {
                    launchURL(
                      url: "https://wa.me/6281246651694",
                    );
                  },
                  child: const Text("Konfirmasi"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  onPressed: () async {
                    for (var i = 0; i < widget.listSheet.length; i++) {
                      await AddTransaction.connectToApi(
                        idUser: widget.idUser,
                        idSchedule: widget.schedule.idSchedule,
                        idDetailRoom: widget.listSheet[i],
                      );
                    }
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const MyApp()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text("Tambahkan"),
                ),
              ),
            ],
          ),
        ));
  }
}
