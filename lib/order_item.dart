class OrderItem {
  final int idMakanan;
  final String namaMakanan;
  final String urlImage;
  final int hargaMakanan;
  int jumlahOrder;

  OrderItem({
    required this.idMakanan,
    required this.namaMakanan,
    required this.urlImage,
    required this.hargaMakanan,
    this.jumlahOrder = 1,
  });
}
