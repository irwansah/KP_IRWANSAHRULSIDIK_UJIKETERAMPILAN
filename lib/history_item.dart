class HistoryItem {
  final String id;
  final DateTime tanggal;
  final String payment;
  final String address;
  final int totalHarga;
  final int jumlahItem;
  final String status;

  HistoryItem({
    required this.id,
    required this.tanggal,
    required this.totalHarga,
    required this.jumlahItem,
    required this.payment,
    required this.address,
    required this.status,
  });
}
