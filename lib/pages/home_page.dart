
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DATA SEMENTARA REQUEST PEMBELI
  final List<Map<String, dynamic>> requests = [
    {
      'nama': 'Andi',
      'pesanan': 'Mie Ayam x2, Es Teh x1',
      'total': 35000,
      'status': 'Menunggu',
    },
    {
      'nama': 'Budi',
      'pesanan': 'Es Teh x3',
      'total': 15000,
      'status': 'Menunggu',
    },
    {
      'nama': 'Siti',
      'pesanan': 'Mie Ayam x1',
      'total': 15000,
      'status': 'Menunggu',
    },
  ];

  void ubahStatus(int index, String status) {
    setState(() {
      requests[index]['status'] = status;
    });
  }

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

      // APP BAR
      appBar: AppBar(
        backgroundColor: warna.secondary,
        title: const Text(
          'H O M E',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // DRAWER
      drawer: Drawer(
        backgroundColor: warna.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.food_bank_rounded,
                    color: warna.inversePrimary,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 25),

                _drawerItem(context, Icons.home, 'H O M E', '/home', warna),
                const SizedBox(height: 25),

                _drawerItem(context, Icons.food_bank_rounded, 'F O O D S', '/foods', warna),
                const SizedBox(height: 25),

                _drawerItem(context, Icons.shopping_cart, 'K A S I R', '/kasir', warna),
                const SizedBox(height: 25),

                _drawerItem(context, Icons.access_time, 'H I S T O R I', '/histori', warna),
                const SizedBox(height: 25),

                _drawerItem(context, Icons.account_circle_sharp, 'P R O F I L', '/profile', warna),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 75),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: warna.inversePrimary,
                ),
                title: Text(
                  'L O G O U T',
                  style: TextStyle(color: warna.inversePrimary),
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

      // BODY
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // MENU TERLARIS HARI INI
          _card(
            warna,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu Terlaris Hari Ini',
                  style: _judulStyle(warna),
                ),

                const SizedBox(height: 16),

                _menuTerlaris(
                  warna,
                  Icons.restaurant,
                  'Makanan',
                  'Nasgor',
                ),

                const SizedBox(height: 16),

                _menuTerlaris(
                  warna,
                  Icons.local_cafe,
                  'Minuman',
                  'Es Teh',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // TOTAL PENDAPATAN
          _card(
            warna,
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: warna.inversePrimary,
                  size: 32,
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pendapatan Hari Ini',
                        style: _judulStyle(warna).copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatRupiah(67676767),
                        style: TextStyle(
                          color: warna.inversePrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // PELANGGAN DILAYANI
          _card(
            warna,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pelanggan Dilayani',
                  style: _judulStyle(warna),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _statistikPelanggan(
                        warna,
                        Icons.check_circle,
                        Colors.green,
                        '67',
                        'Diterima',
                      ),
                    ),

                    Container(
                      height: 65,
                      width: 1,
                      color: warna.inversePrimary.withValues(alpha: 0.3),
                    ),

                    Expanded(
                      child: _statistikPelanggan(
                        warna,
                        Icons.cancel,
                        Colors.red,
                        '21',
                        'Ditolak',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // JUDUL REQUEST PEMBELI
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Request Pembeli',
                style: _judulStyle(warna).copyWith(fontSize: 20),
              ),

              Text(
                '${requests.where((r) => r['status'] == 'Menunggu').length} menunggu',
                style: TextStyle(
                  color: warna.inversePrimary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // LIST REQUEST PEMBELI
          if (requests.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Belum ada request pembeli.'),
              ),
            )
          else
            ...List.generate(requests.length, (index) {
              final request = requests[index];
              final status = request['status'] as String;

              return Card(
                color: warna.secondary,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAMA DAN STATUS
                      Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 36,
                            color: warna.inversePrimary,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              request['nama'],
                              style: TextStyle(
                                color: warna.inversePrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Text(
                            status,
                            style: TextStyle(
                              color: status == 'Menunggu'
                                  ? Colors.orange
                                  : status == 'Diterima'
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // DETAIL PESANAN
                      Text(
                        request['pesanan'],
                        style: TextStyle(color: warna.inversePrimary),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        formatRupiah(request['total']),
                        style: TextStyle(
                          color: warna.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // TOMBOL TERIMA DAN TOLAK
                      if (status == 'Menunggu') ...[
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ubahStatus(index, 'Ditolak');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Tolak'),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ubahStatus(index, 'Diterima');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Terima'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  // DRAWER ITEM
  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
    ColorScheme warna,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        leading: Icon(icon, color: warna.inversePrimary),
        title: Text(
          title,
          style: TextStyle(color: warna.inversePrimary),
        ),
        onTap: () {
          Navigator.pop(context);

          if (route != '/home') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }

  // CARD UMUM
  Widget _card(ColorScheme warna, {required Widget child}) {
    return Card(
      color: warna.secondary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }

  // STYLE JUDUL
  TextStyle _judulStyle(ColorScheme warna) {
    return TextStyle(
      color: warna.inversePrimary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  // MENU TERLARIS
  Widget _menuTerlaris(
    ColorScheme warna,
    IconData ikon,
    String kategori,
    String nama,
  ) {
    return Row(
      children: [
        Icon(
          ikon,
          color: warna.inversePrimary,
          size: 28,
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kategori,
                style: TextStyle(
                  color: warna.inversePrimary.withValues(alpha: 0.7),
                ),
              ),
              Text(
                nama,
                style: TextStyle(
                  color: warna.inversePrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STATISTIK PELANGGAN
  Widget _statistikPelanggan(
    ColorScheme warna,
    IconData ikon,
    Color warnaIkon,
    String jumlah,
    String label,
  ) {
    return Column(
      children: [
        Icon(ikon, color: warnaIkon, size: 30),
        const SizedBox(height: 8),

        Text(
          jumlah,
          style: TextStyle(
            color: warna.inversePrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          label,
          style: TextStyle(color: warna.inversePrimary),
        ),
      ],
    );
  }
}
