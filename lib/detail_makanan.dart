import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_item.dart';
import 'order_provider.dart';
import 'package:intl/intl.dart';

class DetailMakananPage extends StatelessWidget {
  final Map<String, dynamic> makanan;

  void _tambahPesanan(BuildContext context) {
    final orderItem = OrderItem(
      idMakanan: makanan['id_makanan'],
      namaMakanan: makanan['nama_makanan'],
      urlImage: makanan['url_image'],
      hargaMakanan: makanan['harga'],
      jumlahOrder: 1,
    );

    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final existingItemIndex = orderProvider.dataListOrder.indexWhere(
      (item) => item.idMakanan == orderItem.idMakanan,
    );

    if (existingItemIndex != -1) {
      // Jika item dengan ID yang sama sudah ada, tambahkan jumlah pesanan
      final existingItem = orderProvider.dataListOrder[existingItemIndex];
      orderProvider.tambahJumlahOrder(existingItem);
    } else {
      // Jika tidak ada item dengan ID yang sama, tambahkan item baru
      orderProvider.tambahOrder(orderItem);
    }
    // Tampilkan pesan berhasil
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Berhasil Dipesan'),
          content:
              Text('${orderItem.namaMakanan} telah ditambahkan ke pesanan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Kembali ke halaman list menu
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  DetailMakananPage({required this.makanan});

  @override
  Widget build(BuildContext context) {
    final hargaFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
            .format(makanan['harga']);

    return Scaffold(
      appBar: AppBar(
        title: Text('BurgerQueens'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 81, 7),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              makanan['url_image'],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            makanan['nama_makanan'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            makanan['detail_makanan'],
            style: TextStyle(color: const Color.fromARGB(255, 140, 140, 140)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            hargaFormatted,
            textScaleFactor: 2,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _tambahPesanan(context);
            },
            child: Text('Order'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 81, 7),
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
