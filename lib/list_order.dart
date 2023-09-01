import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'history_provider.dart';
import 'history_item.dart';
import 'order_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';

class ListOrderPage extends StatefulWidget {
  @override
  _ListOrderPageState createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  String _selectedItem = 'COD';
  String _address = '';

  List<String> _options = ['COD', 'QRIS', "Virtual Account BCA"];

  void _tambahHistory(BuildContext context, int total, int jml) {
    DateTime currentDateTime = DateTime.now();

    var uuid = Uuid();
    String generatedUuid = uuid.v4(); // Generate a random UUID

    final history = HistoryItem(
        id: generatedUuid,
        tanggal: currentDateTime,
        payment: _selectedItem,
        address: _address,
        totalHarga: total,
        jumlahItem: jml);

    final historyProvider =
        Provider.of<HistoryProvider>(context, listen: false);

    // Tampilkan pesan berhasil
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Berhasil'),
          content: Text('Pesanan Berhasil'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor:
                    const Color.fromARGB(255, 255, 81, 7), // Background color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      body: orderProvider.dataListOrder.isEmpty
          ? Center(
              child: Text(
                'Belum ada pesanan',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orderProvider.dataListOrder.length,
                    itemBuilder: (context, index) {
                      final pesanan = orderProvider.dataListOrder[index];

                      final hargaFormatted = NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                          .format(pesanan.hargaMakanan);

                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 183, 183, 183)))),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              pesanan.urlImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          tileColor: Color.fromARGB(255, 246, 246, 246),
                          title: Text(pesanan.namaMakanan),
                          subtitle: Text(hargaFormatted),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (pesanan.jumlahOrder == 1) {
                                    orderProvider.hapusOrder(pesanan);
                                  } else {
                                    orderProvider.kurangiOrder(pesanan);
                                  }
                                },
                              ),
                              Text(pesanan.jumlahOrder.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  orderProvider.tambahJumlahOrder(pesanan);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Tampilkan total harga di bagian bawah
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(orderProvider.totalHarga),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Biaya Delivery',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(12000),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Bayar',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp',
                                      decimalDigits: 0)
                                  .format(orderProvider.totalHarga + 12000),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 153, 153, 153))),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              icon: null, // Remove the dropdown icon
                              borderRadius: BorderRadius.circular(10),
                              padding: EdgeInsets.only(left: 10),
                              value: _selectedItem,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedItem = newValue.toString();
                                });
                              },
                              items: _options
                                  .map<DropdownMenuItem<dynamic>>((value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textScaleFactor: 0.8,
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                      Container(
                        width: double.infinity,
                        height: 40,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _address = value.toString();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Isi Alamat Pengiriman',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle logika pesan sekarang
                            _tambahHistory(
                                context,
                                orderProvider.totalHarga + 12000,
                                orderProvider.jumlahItem);

                              // orderProvider.hapusOrder()
                          },
                          child: Text('Pesan Sekarang'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 81, 7),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
