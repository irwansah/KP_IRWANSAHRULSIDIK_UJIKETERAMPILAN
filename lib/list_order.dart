import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'order_provider.dart';

class ListOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      body: orderProvider
              .dataListOrder.isEmpty // Periksa jika daftar pesanan kosong
          ? Center(
              child: Text(
                'Belum ada pesanan',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: orderProvider.dataListOrder.length,
              itemBuilder: (context, index) {
                final pesanan = orderProvider.dataListOrder[index];
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 183, 183, 183))),
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
                    subtitle: Text('Harga: ${pesanan.hargaMakanan}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //     onPressed: () {
                        //       orderProvider.hapusOrder(pesanan);
                        //     },
                        //     icon: Icon(Icons.delete)),
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
    );
  }
}
