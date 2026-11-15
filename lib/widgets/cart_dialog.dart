import 'package:flutter/material.dart';
import 'package:kaciru_desu/models/food.dart';

class CartDialog extends StatelessWidget {
  final Map<Food, int> keranjang;
  final int totalHarga;
  final void Function(Food food, int perubahan, VoidCallback refresh)
  onUbahJumlah;
  final void Function(Food food, VoidCallback refresh) onHapus;

  const CartDialog({
    super.key,
    required this.keranjang,
    required this.totalHarga,
    required this.onUbahJumlah,
    required this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text('Keranjang Belanja'),
          content: SizedBox(
            width: double.maxFinite,
            child: keranjang.isEmpty
                ? const Text('Keranjang masih kosong.')
                : ListView(
                    shrinkWrap: true,
                    children: keranjang.entries.map((entry) {
                      final food = entry.key;
                      final jumlah = entry.value;
                      final subtotal = food.hargaMakanan * jumlah;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(food.namaMakanan),
                        subtitle: Text('Rp $subtotal'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                onUbahJumlah(
                                  food,
                                  -1,
                                  () => setDialogState(() {}),
                                );
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('$jumlah'),
                            IconButton(
                              onPressed: () {
                                onUbahJumlah(
                                  food,
                                  1,
                                  () => setDialogState(() {}),
                                );
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                            IconButton(
                              onPressed: () {
                                onHapus(food, () => setDialogState(() {}));
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
          actions: [
            Text(
              'Total: Rp $totalHarga',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
