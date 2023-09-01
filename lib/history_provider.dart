import 'package:flutter/material.dart';
import 'history_item.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryItem> _historyList = [];

  List<HistoryItem> get historyList => _historyList;

  // Menambahkan riwayat pesanan baru
  void tambahHistory(HistoryItem historyItem) {
    _historyList.add(historyItem);
    notifyListeners();
  }

  // Menghapus riwayat pesanan berdasarkan ID
  void hapusHistory(int id) {
    _historyList.removeWhere((historyItem) => historyItem.id == id);
    notifyListeners();
  }
}
