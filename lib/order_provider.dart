import 'package:flutter/material.dart';
import 'order_item.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderItem> _dataListOrder = [];

  List<OrderItem> get dataListOrder => _dataListOrder;

  void tambahOrder(OrderItem orderItem) {
    _dataListOrder.add(orderItem);
    notifyListeners();
  }

  void hapusOrder(OrderItem orderItem) {
    _dataListOrder.remove(orderItem);
    notifyListeners();
  }

  void kurangiOrder(OrderItem orderItem) {
    if (orderItem.jumlahOrder > 1) {
      orderItem.jumlahOrder--;
      notifyListeners();
    }
  }

  void tambahJumlahOrder(OrderItem orderItem) {
    orderItem.jumlahOrder++;
    notifyListeners();
  }
}
