class Food {
  final String namaMakanan;
  final String kategoriMakanan;
  final int hargaMakanan;
  final int stockMakanan;

  Food({
    required this.namaMakanan,
    required this.kategoriMakanan,
    required this.hargaMakanan,
    required this.stockMakanan,
  });
}

final List<Food> foods = [
  Food(namaMakanan: "Mie Ayam",kategoriMakanan: "Makanan", hargaMakanan: 15000, stockMakanan: 50),
  Food(namaMakanan: "Es Teh",kategoriMakanan: "Minuman", hargaMakanan: 5000, stockMakanan: 75),
];
