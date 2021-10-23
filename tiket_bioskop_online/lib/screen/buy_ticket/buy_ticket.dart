import 'package:flutter/material.dart';
import 'package:tiket_bioskop_online/constant/api.dart';
import 'package:tiket_bioskop_online/model/movie_model.dart';
import 'package:tiket_bioskop_online/model/schedule_id.dart';
import 'package:tiket_bioskop_online/model/sheet_id.dart';
import 'package:tiket_bioskop_online/screen/validation/validation_screen.dart';

class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen(
      {Key? key,
      required this.movie,
      required this.schedule,
      required this.idUser})
      : super(key: key);
  final Movie movie;
  final ScheduleMovie schedule;
  final int idUser;
  @override
  _BuyTicketScreenState createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  List<int> sheets = [];
  _getSheets() async {
    dataSheets = [];
    await SheetModel.connectToApi(id: widget.schedule.idSchedule)
        .then((value) => dataSheets = value);
  }

  Widget status(Color? color, String stat) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 10,
          width: 10,
          color: color,
        ),
        Text(stat),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beli tiket"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              status(Colors.blue, "Tersedia"),
              status(Colors.grey, "Terpesan"),
              status(Colors.green, "Dipilih"),
            ],
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
            ),
            child: const Center(
              child: Text("layar"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                  future: _getSheets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        if (dataMovie.isEmpty) {
                          return const Center(
                            child: Text("Maaf Movie Belum Tersedia"),
                          );
                        } else {
                          return GridView.builder(
                              itemCount: dataSheets.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // return
                                bool served = false;
                                for (var i = 0; i < sheets.length; i++) {
                                  if (sheets[i] == dataSheets[index].id) {
                                    served = true;
                                    i = sheets.length;
                                  }
                                }
                                return GestureDetector(
                                  onTap: () {
                                    if (dataSheets[index].sold == false) {
                                      for (var i = 0; i < sheets.length; i++) {
                                        if (sheets[i] == dataSheets[index].id) {
                                          served = !served;
                                          i = sheets.length;
                                        }
                                      }
                                      if (sheets
                                          .contains(dataSheets[index].id)) {
                                        served = false;
                                        sheets.remove(dataSheets[index].id);
                                      } else {
                                        sheets.add(dataSheets[index].id);
                                        served = true;
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (dataSheets[index].sold)
                                          ? Colors.grey
                                          : (served)
                                              ? Colors.green
                                              : Colors.blue,
                                    ),
                                    child: Center(
                                        child: Text(dataSheets[index].name)),
                                  ),
                                );
                              });
                        }
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
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
              onPressed: () {
                if (sheets.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ValidationScreen(
                        schedule: widget.schedule,
                        movie: widget.movie,
                        listSheet: sheets,
                        idUser: widget.idUser,
                      ),
                    ),
                  );
                }
              },
              child: const Text("Lihat Detail Pembelian"),
            ),
          ),
        ],
      ),
    );
  }
}
