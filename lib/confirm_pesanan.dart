import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'history_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class ConfirmPesananPage extends StatelessWidget {
  final String id;
  final String textToQR = "Ini adalah teks yang ingin diubah menjadi QR Code.";

  const ConfirmPesananPage({super.key, required this.id});
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
    final detail = historyProvider.getDetailHistoryById(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BurgerQueens'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 81, 7),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Pesanan Anda",
                textAlign: TextAlign.center,
                textScaleFactor: 2,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 183, 183, 183),
                    width: 1,
                  ),
                ),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pembayaran:'),
                  Text(detail!.payment),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 183, 183, 183),
                    width: 1,
                  ),
                ),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Bayar:'),
                  Text(NumberFormat.currency(
                          locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                      .format(detail.totalHarga)),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 183, 183, 183),
                    width: 1,
                  ),
                ),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Status:'),
                  Text(checkStatus(detail.status)),
                ],
              ),
            ),
            if (detail.status == "pending" && detail.payment == "VA BCA")
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Virtual Account BCA",
                      textScaleFactor: 1.2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      "172682782829289",
                      style: TextStyle(
                          backgroundColor: Color.fromARGB(255, 223, 223, 223)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Silahkan salin kode pembayaran dan \n lakukan pembayaran",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            if (detail.status == "pending" && detail.payment == "QRIS")
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text("QRIS"),
                    QrImageView(data: textToQR, size: 300),
                    const Text("Pindai atau Unggah gambar QRCode ini"),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 81, 7),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {},
                child: const Text('Cek Status Pesanan'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 81, 7),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
