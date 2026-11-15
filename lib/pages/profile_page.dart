
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String namaToko = 'Kaciru Desu';
  final String idToko = 'Toko-001';
  final String bioToko =
      'Menyediakan berbagai makanan dan minuman dengan harga terjangkau.';

  final int totalPendapatan = 67676767;
  final int makananTerjual = 124;
  final int minumanTerjual = 89;

  final List<Map<String, dynamic>> menuTerpopuler = const [
    {
      'nama': 'Nasi Goreng',
      'kategori': 'Makanan',
      'terjual': 67,
      'icon': Icons.rice_bowl,
    },
    {
      'nama': 'Es Teh',
      'kategori': 'Minuman',
      'terjual': 54,
      'icon': Icons.local_drink,
    },
    {
      'nama': 'Mie Ayam',
      'kategori': 'Makanan',
      'terjual': 43,
      'icon': Icons.ramen_dining,
    },
  ];

  final List<Map<String, dynamic>> ulasan = const [
    {
      'nama': 'Andi',
      'rating': 5,
      'komentar': 'Makanannya enak dan harganya terjangkau!',
      'tanggal': '15 Nov 2026',
    },
    {
      'nama': 'Budi',
      'rating': 4,
      'komentar': 'Pelayanan cepat, minumannya juga segar.',
      'tanggal': '14 Nov 2026',
    },
    {
      'nama': 'Siti',
      'rating': 5,
      'komentar': 'Puas banget, bakal beli lagi.',
      'tanggal': '13 Nov 2026',
    },
  ];

  String formatRupiah(int nominal) {
    return 'Rp${nominal.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: warna.surface,

      appBar: AppBar(
        backgroundColor: warna.secondary,
        title: const Text(
          'P R O F I L',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // DRAWER MENGIKUTI FOODS PAGE
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.food_bank_rounded,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "H O M E",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.food_bank_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "F O O D S",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/foods');
                    },
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "K A S I R",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/kasir');
                    },
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.access_time,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "H I S T O R I",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/histori');
                    },
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle_sharp,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      "P R O F I L",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 75),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  "L O G O U T",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // IDENTITAS TOKO
          Card(
            color: warna.secondary,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: warna.surface,
                    child: Icon(
                      Icons.storefront,
                      size: 45,
                      color: warna.inversePrimary,
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    namaToko,
                    style: TextStyle(
                      color: warna.inversePrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'ID: $idToko',
                    style: TextStyle(
                      color: warna.inversePrimary.withValues(alpha: 0.7),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    bioToko,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: warna.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          _judulBagian('Statistik Toko', warna),

          Card(
            color: warna.secondary,
            elevation: 0,
            child: Column(
              children: [
                _statistik(
                  warna,
                  Icons.account_balance_wallet,
                  'Total Pendapatan',
                  formatRupiah(totalPendapatan),
                ),
                const Divider(),
                _statistik(
                  warna,
                  Icons.rice_bowl,
                  'Makanan Terjual',
                  '$makananTerjual item',
                ),
                const Divider(),
                _statistik(
                  warna,
                  Icons.local_drink,
                  'Minuman Terjual',
                  '$minumanTerjual item',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _judulBagian('Menu Terpopuler', warna),

          Card(
            color: warna.secondary,
            elevation: 0,
            child: Column(
              children: menuTerpopuler.map((menu) {
                return ListTile(
                  leading: Icon(
                    menu['icon'],
                    color: warna.inversePrimary,
                    size: 28,
                  ),
                  title: Text(
                    menu['nama'],
                    style: TextStyle(
                      color: warna.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    menu['kategori'],
                    style: TextStyle(
                      color: warna.inversePrimary.withValues(alpha: 0.7),
                    ),
                  ),
                  trailing: Text(
                    '${menu['terjual']} terjual',
                    style: TextStyle(
                      color: warna.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          _judulBagian('Rating & Ulasan Pelanggan', warna),

          Card(
            color: warna.secondary,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '4.7',
                    style: TextStyle(
                      color: warna.inversePrimary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Berdasarkan ${ulasan.length} ulasan',
                    style: TextStyle(
                      color: warna.inversePrimary.withValues(alpha: 0.7),
                    ),
                  ),

                  const Divider(height: 28),

                  ...ulasan.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: warna.inversePrimary,
                                size: 30,
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  item['nama'],
                                  style: TextStyle(
                                    color: warna.inversePrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Text(
                                item['tanggal'],
                                style: TextStyle(
                                  color: warna.inversePrimary.withValues(
                                    alpha: 0.7,
                                  ),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < item['rating']
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 17,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            item['komentar'],
                            style: TextStyle(
                              color: warna.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _judulBagian(String judul, ColorScheme warna) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        judul,
        style: TextStyle(
          color: warna.inversePrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _statistik(
    ColorScheme warna,
    IconData ikon,
    String judul,
    String nilai,
  ) {
    return ListTile(
      leading: Icon(
        ikon,
        color: warna.inversePrimary,
        size: 27,
      ),
      title: Text(
        judul,
        style: TextStyle(color: warna.inversePrimary),
      ),
      trailing: Text(
        nilai,
        style: TextStyle(
          color: warna.inversePrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
