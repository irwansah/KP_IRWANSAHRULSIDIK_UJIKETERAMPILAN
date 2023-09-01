import 'package:flutter/material.dart';
import 'history_item.dart';

class HistoryProvider extends ChangeNotifier {
  final List<HistoryItem> _historyList = [];

  List<HistoryItem> get historyList => _historyList;

  // Menambahkan riwayat pesanan baru
  void tambahHistory(HistoryItem historyItem) {
    _historyList.add(historyItem);
    notifyListeners();
  }
}
