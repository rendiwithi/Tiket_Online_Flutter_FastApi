import 'package:flutter/material.dart';
import 'package:tiket_bioskop_online/constant/api.dart';
import 'package:tiket_bioskop_online/model/movie_model.dart';
import 'package:tiket_bioskop_online/screen/detail/detail_movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _getMovie() async {
    dataMovie = [];
    await Movie.connectToApi().then((value) => dataMovie = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiket Bioskop Online"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.autorenew),
        onPressed: () {
          setState(() {});
        },
      ),
      body: FutureBuilder(
        future: _getMovie(),
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
                return ListView.builder(
                  itemCount: dataMovie.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMovieScreen(
                                movie: dataMovie[index],
                              ),
                            ),
                          );
                        },
                        leading: Image.network(
                          dataMovie[index].imgUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        title: Text(dataMovie[index].title),
                        subtitle: Text(dataMovie[index].desc),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              }
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
