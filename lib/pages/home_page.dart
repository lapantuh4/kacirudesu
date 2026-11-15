import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data sementara request pembeli
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
    return 'Rp${nominal.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: warna.surface,

      appBar: AppBar(
        backgroundColor: warna.secondary,
        title: const Text(
          'H O M E',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // Tetap gunakan drawer milikmu di sini.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // SAPAAN
          Text(
            'Welcome, User!',
            style: TextStyle(
              color: warna.inversePrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Berikut ringkasan keuangan tokomu.',
            style: TextStyle(
              color: warna.inversePrimary.withValues(alpha: 0.7),
            ),
          ),

          const SizedBox(height: 20),

          // RINGKASAN KEUANGAN
          _KeuanganCard(
            judul: 'Pemasukan',
            nominal: formatRupiah(500000),
            ikon: Icons.trending_up,
            warna: Colors.green,
          ),

          const SizedBox(height: 12),

          _KeuanganCard(
            judul: 'Pengeluaran',
            nominal: formatRupiah(150000),
            ikon: Icons.trending_down,
            warna: Colors.red,
          ),

          const SizedBox(height: 12),

          _KeuanganCard(
            judul: 'Laba Bersih',
            nominal: formatRupiah(350000),
            ikon: Icons.account_balance_wallet,
            warna: warna.inversePrimary,
          ),

          const SizedBox(height: 28),

          // JUDUL REQUEST
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Request Pembeli',
                style: TextStyle(
                  color: warna.inversePrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                      // NAMA PEMBELI DAN STATUS
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

                      // TOMBOL AKSI
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
}

// WIDGET CARD RINGKASAN KEUANGAN
class _KeuanganCard extends StatelessWidget {
  final String judul;
  final String nominal;
  final IconData ikon;
  final Color warna;

  const _KeuanganCard({
    required this.judul,
    required this.nominal,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    final warnaTema = Theme.of(context).colorScheme;

    return Card(
      color: warnaTema.secondary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(ikon, color: warna, size: 32),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      color: warnaTema.inversePrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    nominal,
                    style: TextStyle(
                      color: warnaTema.inversePrimary,
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
    );
  }
}
