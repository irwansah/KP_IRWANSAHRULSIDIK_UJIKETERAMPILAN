import 'package:flutter/material.dart';

class ConfirmPesananPage extends StatelessWidget {
  final int totalHarga;

  ConfirmPesananPage({required this.totalHarga});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pesanan'),
      ),
      body: Column(
        children: [
          Text('Total Harga: $totalHarga'),
          ElevatedButton(
            onPressed: () {
              // Implementasikan logika selesaikan pesanan di sini
            },
            child: Text('Selesaikan Pesanan'),
          ),
        ],
      ),
    );
  }
}
