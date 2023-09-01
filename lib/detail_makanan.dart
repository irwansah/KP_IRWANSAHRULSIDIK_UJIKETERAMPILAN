import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_item.dart';
import 'order_provider.dart';
import 'package:intl/intl.dart';

class DetailMakananPage extends StatefulWidget {
  final Map<String, dynamic> makanan;

  const DetailMakananPage({super.key, required this.makanan});

  @override
  DetailMakananPageState createState() => DetailMakananPageState();
}

class DetailMakananPageState extends State<DetailMakananPage> {
  int _inputOrder = 1;
  void _tambahPesanan(BuildContext context) {
    final orderItem = OrderItem(
      idMakanan: widget.makanan['id_makanan'],
      namaMakanan: widget.makanan['nama_makanan'],
      urlImage: widget.makanan['url_image'],
      hargaMakanan: widget.makanan['harga'],
      jumlahOrder: _inputOrder,
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
          title: const Text('Berhasil Dipesan'),
          content:
              Text('${orderItem.namaMakanan} telah ditambahkan ke pesanan.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor:
                    const Color.fromARGB(255, 255, 81, 7), // Background color
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Kembali ke halaman list menu
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hargaFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
            .format(widget.makanan['harga']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BurgerQueens'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 81, 7),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.makanan['url_image'],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.makanan['nama_makanan'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: Text(
                widget.makanan['detail_makanan'],
                style: const TextStyle(color: Color.fromARGB(255, 86, 86, 86)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hargaFormatted,
              textScaleFactor: 2,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_inputOrder != 1) {
                      setState(() {
                        _inputOrder--;
                      });
                    }
                  },
                ),
                // Text(_inputOrder.toString()),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 50,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors
                        .white, // You can change the background color here
                  ),
                  child: Text(
                    _inputOrder.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0, // You can adjust the text size here
                      fontWeight: FontWeight
                          .w500, // You can change the font weight here
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _inputOrder++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _tambahPesanan(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 81, 7),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Pesan'),
            ),
          ],
        ),
      ),
    );
  }
}
