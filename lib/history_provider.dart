import 'package:flutter/material.dart';
import 'history_item.dart';

class HistoryProvider extends ChangeNotifier {
  final List<HistoryItem> _historyList = [];

  List<HistoryItem> get historyList => _historyList;

  void tambahHistory(HistoryItem historyItem) {
    _historyList.add(historyItem);
    notifyListeners();
  }

  void hapusHistory(String id) {
    _historyList.removeWhere((historyItem) => historyItem.id == id);
    notifyListeners();
  }

  HistoryItem? getDetailHistoryById(String id) {
    final historyItem =
        _historyList.firstWhere((historyItem) => historyItem.id == id);
    return historyItem;
  }
}
