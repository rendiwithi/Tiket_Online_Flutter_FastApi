import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiket_bioskop_online/constant/change_date.dart';
import 'package:tiket_bioskop_online/constant/change_time.dart';
import 'package:tiket_bioskop_online/model/detail_transaction.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailHistoryScreen extends StatefulWidget {
  const DetailHistoryScreen({
    required this.model,
    Key? key,
  }) : super(key: key);
  final DetailTransaction model;
  @override
  _DetailHistoryScreenState createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  launchURL({required String url}) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("pesan sekarang"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.model.imgUrl), fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  widget.model.movieTitle + "-" + widget.model.codeSheet,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                  changeDate(widget.model.date) +
                      "-" +
                      changeTime(widget.model.date),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "lakukan pembayaran Rp.${widget.model.price}\nke rekening 968430",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Lalu Konfirmasi pemabayaran\ndi kasir / via wa di bawah\n\ndan dengan kode\n${widget.model.idSchedule.toString()}.${widget.model.idTransaction.toString()}.${widget.model.codeSheet.toString()}\ndengan menyertakan bukti pembayaran",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Center(
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
