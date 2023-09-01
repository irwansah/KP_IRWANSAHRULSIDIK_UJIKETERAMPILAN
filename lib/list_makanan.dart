import 'package:flutter/material.dart';
import 'detail_makanan.dart';

class ListMakananPage extends StatefulWidget {
  @override
  _ListMakananPageState createState() => _ListMakananPageState();
}

class _ListMakananPageState extends State<ListMakananPage> {
  List<Map<String, dynamic>> data_list_makanan = [
    {
      'id_makanan': 1,
      'nama_makanan': 'Double Cheese',
      'url_image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Hamburger_%28black_bg%29.jpg/640px-Hamburger_%28black_bg%29.jpg',
      'detail_makanan':
          'Burger dengan daging sapi yang juicy ditambah dengan keju yang tebal',
      'harga': 15000,
    },
    {
      'id_makanan': 2,
      'nama_makanan': 'Spicy Cicken',
      'url_image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Hamburger_%28black_bg%29.jpg/640px-Hamburger_%28black_bg%29.jpg',
      'detail_makanan':
          'Burger dengan daging sapi yang juicy ditambah dengan keju yang tebal',
      'harga': 15000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data_list_makanan.length,
        itemBuilder: (context, index) {
          final makanan = data_list_makanan[index];
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 183, 183, 183))),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMakananPage(makanan: makanan),
                  ),
                );
              },
              tileColor: Color.fromARGB(255, 246, 246, 246),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  makanan['url_image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  makanan['nama_makanan'],
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.start,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
