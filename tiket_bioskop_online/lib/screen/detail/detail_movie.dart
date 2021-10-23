import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:tiket_bioskop_online/constant/api.dart';
import 'package:tiket_bioskop_online/constant/change_date.dart';
import 'package:tiket_bioskop_online/constant/change_time.dart';
import 'package:tiket_bioskop_online/model/movie_model.dart';
import 'package:tiket_bioskop_online/model/schedule_id.dart';
import 'package:tiket_bioskop_online/screen/buy_ticket/buy_ticket.dart';

class DetailMovieScreen extends StatefulWidget {
  final Movie movie;
  const DetailMovieScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  _getSchedule() async {
    dataSchedule = [];
    await ScheduleMovie.connectToApi(id: widget.movie.id)
        .then((value) => dataSchedule = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 250,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.movie.imgUrl), fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: RatingBarIndicator(
                      rating: widget.movie.rate.toDouble(),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 25.0,
                    ),
                  ),
                  Text(widget.movie.desc),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Pilih Jadwal Tayang",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            Expanded(
              child: FutureBuilder(
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
                          return FutureBuilder(
                            future: _getSchedule(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else {
                                  if (dataSchedule.isEmpty) {
                                    return const Center(
                                      child: Text(
                                          "Maaf Jadwal Tayang Belum Tersedia"),
                                    );
                                  } else {
                                    return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                        ),
                                        itemCount: dataSchedule.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BuyTicketScreen(
                                                    movie: widget.movie,
                                                    schedule:
                                                        dataSchedule[index],
                                                        idUser: u[0].id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(dataSchedule[index]
                                                            .day),
                                                        Text(changeDate(
                                                            dataSchedule[index]
                                                                .start)),
                                                        Text(changeTime(
                                                            dataSchedule[index]
                                                                .start)),
                                                      ],
                                                    ),
                                                    Text(
                                                        "Rp.${dataSchedule[index].price}/tiket"),
                                                  ],
                                                ),
                                              ),
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
                            },
                          );
                        } else {
                          return const Center(
                              child: Text(
                                  "belum login silahkan login untuk melanjutkan"));
                        }
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
