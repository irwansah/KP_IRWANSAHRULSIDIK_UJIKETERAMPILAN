import 'package:flutter/material.dart';
import 'order_item.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderItem> _dataListOrder = [];

  List<OrderItem> get dataListOrder => _dataListOrder;

  int _totalHarga = 0;
  int _jumlahItem = 0;

  int get totalHarga => _totalHarga;
  int get jumlahItem => _jumlahItem;

  void hitungTotalHarga() {
    _totalHarga = 0;
    for (final orderItem in _dataListOrder) {
      _totalHarga += orderItem.hargaMakanan * orderItem.jumlahOrder;
    }
    notifyListeners();
  }

  void hitungJumlahItem() {
    _jumlahItem = 0;
    for (final orderItem in _dataListOrder) {
      _jumlahItem += orderItem.jumlahOrder;
    }
    notifyListeners();
  }

  void tambahOrder(OrderItem orderItem) {
    _dataListOrder.add(orderItem);
    hitungTotalHarga();
    hitungJumlahItem(); // Hitung jumlah item setelah menambahkan pesanan
    notifyListeners();
  }

  void hapusOrder(OrderItem orderItem) {
    _dataListOrder.remove(orderItem);
    hitungTotalHarga();
    hitungJumlahItem(); // Hitung jumlah item setelah menghapus pesanan
    notifyListeners();
  }

  void kurangiOrder(OrderItem orderItem) {
    if (orderItem.jumlahOrder > 1) {
      orderItem.jumlahOrder--;
      hitungTotalHarga();
      hitungJumlahItem(); // Hitung jumlah item setelah mengurangi pesanan
      notifyListeners();
    }
  }

  void tambahJumlahOrder(OrderItem orderItem) {
    orderItem.jumlahOrder++;
    hitungTotalHarga();
    hitungJumlahItem(); // Hitung jumlah item setelah menambah jumlah pesanan
    notifyListeners();
  }

  void bersihkanOrder() {
    _dataListOrder.clear();
    _totalHarga = 0;
    _jumlahItem = 0;
    notifyListeners();
  }
}
