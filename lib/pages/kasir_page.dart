import 'package:flutter/material.dart';
import 'package:kaciru_desu/models/food.dart';
import 'package:kaciru_desu/widgets/food_card_kasir.dart';

import 'package:kaciru_desu/widgets/cart_dialog.dart';

class KasirPage extends StatefulWidget {
  const new({super.key});

  @override
  State<KasirPage> createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  final Map<Food, int> keranjang = {};

  void tampilkanKeranjang() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return CartDialog(
              keranjang: keranjang,
              totalHarga: totalHarga,
              onUbahJumlah: (food, perubahan, refresh) {
                ubahJumlah(food, perubahan);
                setDialogState(() {});
              },
              onHapus: (food, refresh) {
                hapusDariKeranjang(food);
                setDialogState(() {});
              },
            );
          },
        );
      },
    );
  }

  void ubahJumlah(Food food, int perubahan) {
    final jumlahSekarang = keranjang[food] ?? 0;
    final jumlahBaru = jumlahSekarang + perubahan;

    if (jumlahBaru <= 0) {
      setState(() {
        keranjang.remove(food);
      });
      return;
    }

    if (jumlahBaru > food.stockMakanan) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Jumlah melebihi stok!')));
      return;
    }

    setState(() {
      keranjang[food] = jumlahBaru;
    });
  }

  void hapusDariKeranjang(Food food) {
    setState(() {
      keranjang.remove(food);
    });
  }

  void tambahKeKeranjang(Food food) {
    final jumlahSekarang = keranjang[food] ?? 0;

    if (jumlahSekarang >= food.stockMakanan) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Jumlah melebihi stok yang tersedia!')),
        );
      return;
    }

    setState(() {
      keranjang[food] = jumlahSekarang + 1;
    });
  }

  int get totalHarga {
    return keranjang.entries.fold(
      0,
      (total, item) => total + (item.key.hargaMakanan * item.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("K A S I R", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Icons.shopping_cart,
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
                      Navigator.pushReplacementNamed(context, '/foods');
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

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];

          return FoodCardKasir(
            food: food,
            onTambah: () => tambahKeKeranjang(food),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Theme.of(context).textTheme.displayLarge?.color,
          onPressed: tampilkanKeranjang,
          child: const Icon(Icons.shopping_cart),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
