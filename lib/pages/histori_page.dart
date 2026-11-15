
import 'package:flutter/material.dart';

// MODEL TRANSAKSI
class Transaksi {
  final String nomorTransaksi;
  final DateTime tanggal;
  final String namaPelanggan;
  final List<Map<String, dynamic>> pesanan;
  final int total;
  final String metodePembayaran;

  Transaksi({
    required this.nomorTransaksi,
    required this.tanggal,
    required this.namaPelanggan,
    required this.pesanan,
    required this.total,
    required this.metodePembayaran,
  });
}

class HistoriPage extends StatefulWidget {
  const HistoriPage({super.key});

  @override
  State<HistoriPage> createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  final TextEditingController pencarianController =
      TextEditingController();

  DateTime? tanggalDipilih;

  // DATA DUMMY TRANSAKSI
  final List<Transaksi> daftarTransaksi = [
    Transaksi(
      nomorTransaksi: 'TRX-001',
      tanggal: DateTime(2026, 11, 15, 8, 30),
      namaPelanggan: 'Andi',
      pesanan: [
        {'nama': 'Mie Ayam', 'jumlah': 2, 'harga': 15000},
        {'nama': 'Es Teh', 'jumlah': 1, 'harga': 5000},
      ],
      total: 35000,
      metodePembayaran: 'Tunai',
    ),

    Transaksi(
      nomorTransaksi: 'TRX-002',
      tanggal: DateTime(2026, 11, 15, 9, 15),
      namaPelanggan: 'Budi',
      pesanan: [
        {'nama': 'Es Teh', 'jumlah': 3, 'harga': 5000},
      ],
      total: 15000,
      metodePembayaran: 'QRIS',
    ),

    Transaksi(
      nomorTransaksi: 'TRX-003',
      tanggal: DateTime(2026, 11, 15, 10, 20),
      namaPelanggan: 'Siti',
      pesanan: [
        {'nama': 'Nasgor', 'jumlah': 1, 'harga': 15000},
        {'nama': 'Es Teh', 'jumlah': 2, 'harga': 5000},
      ],
      total: 25000,
      metodePembayaran: 'Tunai',
    ),

    Transaksi(
      nomorTransaksi: 'TRX-004',
      tanggal: DateTime(2026, 11, 14, 8, 45),
      namaPelanggan: 'Rizky',
      pesanan: [
        {'nama': 'Mie Ayam', 'jumlah': 1, 'harga': 15000},
      ],
      total: 15000,
      metodePembayaran: 'QRIS',
    ),

    Transaksi(
      nomorTransaksi: 'TRX-005',
      tanggal: DateTime(2026, 11, 14, 11, 30),
      namaPelanggan: 'Dina',
      pesanan: [
        {'nama': 'Nasgor', 'jumlah': 2, 'harga': 15000},
        {'nama': 'Es Teh', 'jumlah': 2, 'harga': 5000},
      ],
      total: 40000,
      metodePembayaran: 'Tunai',
    ),

    Transaksi(
      nomorTransaksi: 'TRX-006',
      tanggal: DateTime(2026, 11, 13, 12, 10),
      namaPelanggan: 'Fajar',
      pesanan: [
        {'nama': 'Es Teh', 'jumlah': 2, 'harga': 5000},
      ],
      total: 10000,
      metodePembayaran: 'QRIS',
    ),
  ];

  final List<String> namaHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  final List<String> namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  // FORMAT RUPIAH
  String formatRupiah(int nominal) {
    return 'Rp${nominal.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  // FORMAT TANGGAL
  String formatTanggal(DateTime tanggal) {
    return '${tanggal.day} ${namaBulan[tanggal.month - 1]} ${tanggal.year}';
  }

  // FORMAT HARI DAN TANGGAL
  String formatHariTanggal(DateTime tanggal) {
    return '${namaHari[tanggal.weekday - 1]}, ${formatTanggal(tanggal)}';
  }

  // FORMAT JAM
  String formatJam(DateTime tanggal) {
    final jam = tanggal.hour.toString().padLeft(2, '0');
    final menit = tanggal.minute.toString().padLeft(2, '0');

    return '$jam:$menit';
  }

  // FILTER TRANSAKSI
  List<Transaksi> get transaksiDifilter {
    final keyword = pencarianController.text.trim().toLowerCase();

    return daftarTransaksi.where((transaksi) {
      final tanggal = transaksi.tanggal;

      // FILTER TANGGAL DARI DATE PICKER
      if (tanggalDipilih != null) {
        if (tanggal.year != tanggalDipilih!.year ||
            tanggal.month != tanggalDipilih!.month ||
            tanggal.day != tanggalDipilih!.day) {
          return false;
        }
      }

      // FORMAT TANGGAL UNTUK PENCARIAN
      final tanggalLengkap = formatTanggal(tanggal).toLowerCase();
      final hari = namaHari[tanggal.weekday - 1].toLowerCase();

      final tanggalNumerik =
          '${tanggal.day.toString().padLeft(2, '0')}/'
          '${tanggal.month.toString().padLeft(2, '0')}/'
          '${tanggal.year}';

      final tanggalISO =
          '${tanggal.year}-'
          '${tanggal.month.toString().padLeft(2, '0')}-'
          '${tanggal.day.toString().padLeft(2, '0')}';

      // DATA YANG BISA DICARI
      final dataPencarian = [
        transaksi.nomorTransaksi,
        transaksi.namaPelanggan,
        tanggalLengkap,
        tanggalNumerik,
        tanggalISO,
        hari,
        ...transaksi.pesanan.map((item) => item['nama'].toString()),
      ].join(' ').toLowerCase();

      return dataPencarian.contains(keyword);
    }).toList();
  }

  // KELOMPOKKAN TRANSAKSI PER HARI
  Map<DateTime, List<Transaksi>> get transaksiPerHari {
    final Map<DateTime, List<Transaksi>> kelompok = {};

    for (final transaksi in transaksiDifilter) {
      final tanggal = DateTime(
        transaksi.tanggal.year,
        transaksi.tanggal.month,
        transaksi.tanggal.day,
      );

      kelompok.putIfAbsent(tanggal, () => []);
      kelompok[tanggal]!.add(transaksi);
    }

    return kelompok;
  }

  // DATE PICKER
  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: tanggalDipilih ?? DateTime(2026, 11, 15),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (tanggal != null) {
      setState(() {
        tanggalDipilih = tanggal;
      });
    }
  }

  // HAPUS FILTER
  void hapusFilter() {
    setState(() {
      pencarianController.clear();
      tanggalDipilih = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    final kelompok = transaksiPerHari;

    // URUTKAN TANGGAL DARI TERBARU
    final daftarTanggal = kelompok.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: warna.surface,

      // APP BAR
      appBar: AppBar(
        backgroundColor: warna.secondary,
        title: const Text(
          'H I S T O R I',
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

                _drawerItem(
                  context,
                  Icons.home,
                  'H O M E',
                  '/home',
                  warna,
                ),

                const SizedBox(height: 25),

                _drawerItem(
                  context,
                  Icons.food_bank_rounded,
                  'F O O D S',
                  '/foods',
                  warna,
                ),

                const SizedBox(height: 25),

                _drawerItem(
                  context,
                  Icons.shopping_cart,
                  'K A S I R',
                  '/kasir',
                  warna,
                ),

                const SizedBox(height: 25),

                _drawerItem(
                  context,
                  Icons.access_time,
                  'H I S T O R I',
                  '/histori',
                  warna,
                ),

                const SizedBox(height: 25),

                _drawerItem(
                  context,
                  Icons.account_circle_sharp,
                  'P R O F I L',
                  '/profile',
                  warna,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                bottom: 75,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: warna.inversePrimary,
                ),
                title: Text(
                  'L O G O U T',
                  style: TextStyle(
                    color: warna.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                    context,
                    '/login',
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // BODY
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: pencarianController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Cari tanggal atau nomor transaksi...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: pencarianController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            pencarianController.clear();
                          });
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
            ),
          ),

          // FILTER TANGGAL
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: pilihTanggal,
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      tanggalDipilih == null
                          ? 'Pilih Tanggal'
                          : formatTanggal(tanggalDipilih!),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                if (tanggalDipilih != null ||
                    pencarianController.text.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: hapusFilter,
                    tooltip: 'Hapus filter',
                    icon: const Icon(Icons.filter_alt_off),
                  ),
                ],
              ],
            ),
          ),

          // JUMLAH TRANSAKSI
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${transaksiDifilter.length} transaksi ditemukan',
                style: TextStyle(
                  color: warna.inversePrimary.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),

          // LISTVIEW HISTORI
          Expanded(
            child: daftarTanggal.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 60,
                          color: warna.inversePrimary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada transaksi ditemukan.',
                          style: TextStyle(
                            color: warna.inversePrimary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: daftarTanggal.length,
                    itemBuilder: (context, index) {
                      final tanggal = daftarTanggal[index];
                      final transaksi = kelompok[tanggal]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // JUDUL KELOMPOK TANGGAL
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: warna.inversePrimary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    formatHariTanggal(tanggal),
                                    style: TextStyle(
                                      color: warna.inversePrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${transaksi.length} transaksi',
                                  style: TextStyle(
                                    color: warna.inversePrimary.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // DAFTAR TRANSAKSI PADA TANGGAL TERSEBUT
                          ...transaksi.map(
                            (item) => _transaksiCard(
                              warna,
                              item,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
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
        leading: Icon(
          icon,
          color: warna.inversePrimary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: warna.inversePrimary,
          ),
        ),
        onTap: () {
          Navigator.pop(context);

          if (route != '/histori') {
            Navigator.pushReplacementNamed(
              context,
              route,
            );
          }
        },
      ),
    );
  }

  // CARD TRANSAKSI
  Widget _transaksiCard(
    ColorScheme warna,
    Transaksi transaksi,
  ) {
    return Card(
      color: warna.secondary,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        iconColor: warna.inversePrimary,
        collapsedIconColor: warna.inversePrimary,
        leading: Icon(
          Icons.receipt_long,
          color: warna.inversePrimary,
          size: 28,
        ),

        // RINGKASAN TRANSAKSI
        title: Text(
          transaksi.nomorTransaksi,
          style: TextStyle(
            color: warna.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${transaksi.namaPelanggan} • ${formatJam(transaksi.tanggal)}',
            style: TextStyle(
              color: warna.inversePrimary.withValues(alpha: 0.7),
            ),
          ),
        ),

        // DETAIL TRANSAKSI
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),

        children: [
          const Divider(),

          // DAFTAR PRODUK
          ...transaksi.pesanan.map((item) {
            final jumlah = item['jumlah'] as int;
            final harga = item['harga'] as int;
            final subtotal = jumlah * harga;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item['nama']} x$jumlah',
                      style: TextStyle(
                        color: warna.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    formatRupiah(subtotal),
                    style: TextStyle(
                      color: warna.inversePrimary,
                    ),
                  ),
                ],
              ),
            );
          }),

          const Divider(),

          // METODE PEMBAYARAN
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Metode Pembayaran',
                style: TextStyle(
                  color: warna.inversePrimary,
                ),
              ),
              Text(
                transaksi.metodePembayaran,
                style: TextStyle(
                  color: warna.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // TOTAL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: TextStyle(
                  color: warna.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatRupiah(transaksi.total),
                style: TextStyle(
                  color: warna.inversePrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
