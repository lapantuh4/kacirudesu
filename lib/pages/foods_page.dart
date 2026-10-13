import 'package:flutter/material.dart';
import 'package:kaciru_desu/widgets/food_card.dart';

import '../models/food.dart';

class FoodsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  String makananDicari = '';

  void editMakanan(Food food) {
    final namaController = TextEditingController(text: food.namaMakanan);
    final hargaController = TextEditingController(text: '${food.hargaMakanan}');
    final stokController = TextEditingController(text: '${food.stockMakanan}');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Judul
        title: const Text(
          'Edit Produk',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        // Warna dan bentuk popup
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        // Jarak isi dialog dari pinggir
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 20),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stok',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),

        // Area tombol
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        actions: [
          // Tombol Batal
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.red)),
          ),

          // Tombol Simpan
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                food.namaMakanan = namaController.text;
                food.hargaMakanan =
                    int.tryParse(hargaController.text) ?? food.hargaMakanan;
                food.stockMakanan =
                    int.tryParse(stokController.text) ?? food.stockMakanan;
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void hapusMakanan(Food food) {
    setState(() {
      foods.remove(food);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("F O O D S", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
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
                SizedBox(height: 25),
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
                SizedBox(height: 25),
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
                    },
                  ),
                ),
                SizedBox(height: 25),
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
                SizedBox(height: 25),
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
                SizedBox(height: 25),
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
                      Navigator.pushReplacementNamed(context, '/profile');
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

      body: StatefulBuilder(
        builder: (context, setState) {
          final makananDifilter = foods.where((food) {
            final matchSearch = food.namaMakanan.toLowerCase().contains(
              makananDicari.toLowerCase(),
            );

            return matchSearch;
          }).toList();

          return Column(
            children: [
              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari makanan atau minuman...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      makananDicari = value;
                    });
                  },
                ),
              ),

              // CARD MAKANAN / MINUMAN
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: makananDifilter.length,
                  itemBuilder: (context, index) {
                    final food = makananDifilter[index];

                    return FoodCard(
                      food: food,
                      hapusMakanan: () => hapusMakanan(food),
                      editMakanan: () => editMakanan(food),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
