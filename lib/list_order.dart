import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'confirm_pesanan.dart';
import 'history_provider.dart';
import 'history_item.dart';
import 'location_dialog.dart';
import 'order_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  ListOrderPageState createState() => ListOrderPageState();
}

class ListOrderPageState extends State<ListOrderPage> {
  String _selectedItem = 'COD';
  String _address = '';
  final FocusNode _addressFocusNode = FocusNode();

  final List<String> _options = ['COD', 'QRIS', "VA BCA"];

  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai awal dari _address
    _addressController.text = _address;
  }

  @override
  void dispose() {
    _addressController.dispose(); // Membersihkan controller
    super.dispose();
  }

  void _tambahHistory(BuildContext context, int total, int jml) {
    DateTime currentDateTime = DateTime.now();

    var uuid = const Uuid();
    String generatedUuid = uuid.v4(); // Generate a random UUID

    final history = HistoryItem(
        id: generatedUuid,
        tanggal: currentDateTime,
        payment: _selectedItem,
        address: _address,
        totalHarga: total,
        jumlahItem: jml,
        status: _selectedItem == "COD" ? "process" : "pending");

    final historyProvider =
        Provider.of<HistoryProvider>(context, listen: false);

    historyProvider.tambahHistory(history);
    setState(() {
      _address = "";
      _addressController.text = _address;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmPesananPage(id: generatedUuid),
      ),
    );
  }

  void _showLocationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const LocationDialog(); // Menggunakan LocationDialog dari file terpisah
      },
    );

    if (result != null && result) {
      setState(() {
        _address = 'contoh lokasi dari map';
        _addressController.text = _address; // Perbarui controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: orderProvider.dataListOrder.isEmpty
          ? Center(
              child: Text(
                "Pesanan masih kosong nih. \n\n Anda bisa melihat status pesanan terakhir \n di akun > riwayat pesanan",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderProvider.dataListOrder.length,
                    itemBuilder: (context, index) {
                      final pesanan = orderProvider.dataListOrder[index];

                      final hargaFormatted = NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                          .format(pesanan.hargaMakanan);

                      return Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color:
                                        Color.fromARGB(255, 183, 183, 183)))),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              pesanan.urlImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          tileColor: const Color.fromARGB(255, 246, 246, 246),
                          title: Text(pesanan.namaMakanan),
                          subtitle: Text(hargaFormatted),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (pesanan.jumlahOrder == 1) {
                                    orderProvider.hapusOrder(pesanan);
                                  } else {
                                    orderProvider.kurangiOrder(pesanan);
                                  }
                                },
                              ),
                              // Text(pesanan.jumlahOrder.toString()),
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: 40,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  color: Colors
                                      .white, // You can change the background color here
                                ),
                                child: Text(
                                  pesanan.jumlahOrder.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize:
                                        14, // You can adjust the text size here
                                    fontWeight: FontWeight
                                        .w500, // You can change the font weight here
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
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
                  //Total Harga
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: 'Rp',
                                        decimalDigits: 0)
                                    .format(orderProvider.totalHarga),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Biaya Delivery',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: 'Rp',
                                        decimalDigits: 0)
                                    .format(12000),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Bayar',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: 'Rp',
                                        decimalDigits: 0)
                                    .format(orderProvider.totalHarga + 12000),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromARGB(
                                          255, 153, 153, 153))),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                icon: null, // Remove the dropdown icon
                                borderRadius: BorderRadius.circular(10),
                                padding: const EdgeInsets.only(left: 10),
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
                          height: 45,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Stack(
                            children: [
                              TextField(
                                focusNode: _addressFocusNode,
                                controller:
                                    _addressController, // Atur controller

                                // onChanged: (value) {
                                //   setState(() {
                                //     _address = value.toString();
                                //   });
                                // },
                                decoration: InputDecoration(
                                  labelText: 'Isi Alamat Pengiriman',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  iconSize: 24.0,
                                  icon: const Icon(Icons.location_on),
                                  onPressed: () {
                                    _showLocationDialog(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_address == "") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Perhatian'),
                                      content: const Text(
                                          'Mohon Lengkapi Informasi Alamat & Pembayaran'),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                Colors.white, // Text color
                                            backgroundColor:
                                                const Color.fromARGB(255, 255,
                                                    81, 7), // Background color
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                FocusScope.of(context)
                                    .requestFocus(_addressFocusNode);

                                return;
                              }

                              _tambahHistory(
                                  context,
                                  orderProvider.totalHarga + 12000,
                                  orderProvider.jumlahItem);

                              orderProvider.bersihkanOrder();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 81, 7),
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: const Text('Pesan Sekarang'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
    );
  }
}
