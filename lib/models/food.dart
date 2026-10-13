class Food {
  String namaMakanan;
  int hargaMakanan;
  int stockMakanan;

  Food({
    required this.namaMakanan,
    required this.hargaMakanan,
    required this.stockMakanan,
  });
}

final List<Food> foods = [
  Food(namaMakanan: "Mie Ayam", hargaMakanan: 15000, stockMakanan: 50),
  Food(namaMakanan: "Es Teh", hargaMakanan: 5000, stockMakanan: 75),
  Food(namaMakanan: "Pop Mie", hargaMakanan: 6000, stockMakanan: 50),
];
