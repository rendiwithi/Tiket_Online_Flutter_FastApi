import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tiket_bioskop_online/constant/api.dart';
import 'package:tiket_bioskop_online/model/detail_transaction.dart';
import 'package:tiket_bioskop_online/screen/detail_history/detail_history.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({Key? key}) : super(key: key);

  @override
  _HistoryTransactionScreenState createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen> {
  _getHistory({required int id}) async {
    dataHistory = [];
    await DetailTransaction.connectToApi(id: id)
        .then((value) => dataHistory = value);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histori Transaksi"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.autorenew),
        onPressed: () {
          setState(() {});
        },
      ),
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
                return FutureBuilder(
                  future: _getHistory(id: u[0].id),
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
                        return ListView.builder(
                            itemCount: dataHistory.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: ListTile(
                                onTap: () {},
                                leading: Image.network(
                                  dataHistory[index].imgUrl,
                                  // dataMovie[index].imgUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                isThreeLine: true,
                                title: Text(dataHistory[index].movieTitle,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                subtitle: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailHistoryScreen(
                                          model: dataHistory[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: (dataHistory[index].isPaid)
                                            ? Colors.blue
                                            : Colors.red),
                                    child: Center(
                                      child: Text(
                                          (dataHistory[index].isPaid)
                                              ? "Pembayaran Terkonfirmasi"
                                              : "Belum Bayar",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ));
                            });
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
                  child: Text("belum login silahkan login untuk melanjutkan"),
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
