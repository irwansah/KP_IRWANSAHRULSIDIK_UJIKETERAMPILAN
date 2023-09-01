import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_makanan.dart';

class ListMakananPage extends StatefulWidget {
  const ListMakananPage({super.key});

  @override
  ListMakananPageState createState() => ListMakananPageState();
}

class ListMakananPageState extends State<ListMakananPage> {
  List<Map<String, dynamic>> dataListMakanan = [
    {
      'id_makanan': 1,
      'nama_makanan': 'Double Cheese',
      'url_image': 'https://irwansahrulsidik.com/cdn/burger.png',
      'detail_makanan':
          'Burger dengan daging sapi yang juicy ditambah dengan keju yang tebal',
      'harga': 45000,
    },
    {
      'id_makanan': 2,
      'nama_makanan': 'Spicy Chicken',
      'url_image': 'https://irwansahrulsidik.com/cdn/cspicy.png',
      'detail_makanan':
          'Ayam goreng crispy dengan baluran tepung saus pedas yang nikmat dimulut',
      'harga': 22000,
    },
    {
      'id_makanan': 3,
      'nama_makanan': 'Golden Chicken',
      'url_image': 'https://irwansahrulsidik.com/cdn/cgolden.png',
      'detail_makanan': 'Ayam goreng crispy orginal gurih dan beraroma otentik',
      'harga': 19000,
    },
    {
      'id_makanan': 4,
      'nama_makanan': 'Meal Box',
      'url_image': 'https://irwansahrulsidik.com/cdn/pack.png',
      'detail_makanan': 'Ayam goreng crispy orginal gurih dan beraroma otentik',
      'harga': 54000,
    },
    {
      'id_makanan': 5,
      'nama_makanan': 'Ice Creamy',
      'url_image': 'https://irwansahrulsidik.com/cdn/ice.png',
      'detail_makanan': 'Ayam goreng crispy orginal gurih dan beraroma otentik',
      'harga': 17000,
    },
    {
      'id_makanan': 6,
      'nama_makanan': 'ColaCoca',
      'url_image': 'https://irwansahrulsidik.com/cdn/cola.png',
      'detail_makanan': 'Ayam goreng crispy orginal gurih dan beraroma otentik',
      'harga': 9000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dataListMakanan.length,
        itemBuilder: (context, index) {
          final makanan = dataListMakanan[index];
          return Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromARGB(255, 183, 183, 183)))),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMakananPage(makanan: makanan),
                  ),
                );
              },
              tileColor: const Color.fromARGB(255, 233, 232, 232),
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
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        makanan['nama_makanan'],
                        textScaleFactor: 1.2,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                            .format(makanan['harga']),
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 116, 116, 116)),
                      )
                    ]),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
