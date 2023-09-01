import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uji_keterampilan/history_provider.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          const Text('Nama Akun: John Doe'),
          const Text('Nomor Telepon: 123-456-7890'),
          const Divider(),
          const Text('Riwayat Pesanan'),
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
                              color:
                                  Color.fromARGB(255, 183, 183, 183)))),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    tileColor: const Color.fromARGB(255, 246, 246, 246),
                    title: Text("Jumlah ${history.jumlahItem.toString()}"),
                    subtitle: Text(NumberFormat.currency(
                            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                        .format(history.totalHarga)),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Waktu Pesanan"),
                        Text(DateFormat('y-m-dd HH:mm')
                            .format(history.tanggal)
                            .toString()),
                      ],
                    ),
                  ),
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
