import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'confirm_pesanan.dart';
import 'history_provider.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  String checkStatus(String? status) {
    if (status == "process") {
      return "Pesanan di proses";
    } else if (status == "sent") {
      return "Sedang dikirim";
    } else if (status == "received") {
      return "Pesanan diterima";
    } else {
      return "Menunggu Pembayaran";
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/13304632?v=4',
                        scale: 1),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Irwansah',
                        textScaleFactor: 1.5,
                      ),
                      Text(
                        '085814429029',
                        textScaleFactor: 1.2,
                      ),
                    ],
                  ),
                ],
              )),
          const Divider(
            color: Color.fromARGB(255, 200, 200, 200),
            thickness: 1,
            height: 50,
          ),
          const Text(
            'Riwayat Pesanan',
            textScaleFactor: 1.4,
          ),
          const Divider(
            color: Color.fromARGB(255, 200, 200, 200),
            thickness: 1,
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: historyProvider.historyList.length,
              itemBuilder: (context, index) {
                final history = historyProvider.historyList[index];

                return Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 183, 183, 183)))),
                  child: Column(children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      tileColor: const Color.fromARGB(255, 246, 246, 246),
                      title: Text("${history.jumlahItem.toString()} item"),
                      subtitle: Text(NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                          .format(history.totalHarga)),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '${history.payment}  / ${checkStatus(history.status)}'),
                          Text(
                              'Waktu Pesanan : ${DateFormat('y-m-dd HH:mm').format(history.tanggal).toString()}'),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 81, 7),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ConfirmPesananPage(id: history.id),
                            ),
                          );
                        },
                        child: const Text("Lihat Pesanan"),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> listRiwayatPesanan = [];
