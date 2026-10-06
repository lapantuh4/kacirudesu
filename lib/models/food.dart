class Food {
  final String namaMakanan;
  final int hargaMakanan;
  final int stockMakanan;

  Food({
    required this.namaMakanan,
    required this.hargaMakanan,
    required this.stockMakanan,
  });
}

final List<Food> foods = [
  Food(namaMakanan: "Mie Ayam", hargaMakanan: 15000, stockMakanan: 50),
  Food(namaMakanan: "Es Teh", hargaMakanan: 5000, stockMakanan: 75),
];
