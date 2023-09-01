import 'package:flutter/material.dart';

class ConfirmPesananPage extends StatelessWidget {
  final int totalHarga;
  final String payment;

  const ConfirmPesananPage({super.key, required this.totalHarga, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BurgerQueens'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 81, 7),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Column(
        children: [
          Text('Total Harga: $totalHarga'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Selesaikan Pesanan'),
          ),
        ],
      ),
    );
  }
}
