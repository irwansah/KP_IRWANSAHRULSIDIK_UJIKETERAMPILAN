import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Column(
        children: [
          Text('Nama Akun: John Doe'),
          Text('Nomor Telepon: 123-456-7890'),
          Divider(),
          Text('Riwayat Pesanan'),
          Expanded(
            child: ListView.builder(
              itemCount: listRiwayatPesanan.length,
              itemBuilder: (context, index) {
                final pesanan = listRiwayatPesanan[index];
                return ListTile(
                  title: Text('ID Pesanan: ${pesanan['id_pesanan']}'),
                  subtitle: Text('Total Harga: ${pesanan['total_harga']}'),
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
