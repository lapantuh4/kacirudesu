import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodCard extends StatelessWidget {
  final void Function()? hapusMakanan;
  final void Function()? editMakanan;
  final Food food;

  const FoodCard({super.key, required this.food, required this.hapusMakanan, required this.editMakanan});

  @override
  Widget build(BuildContext context) {
    return 
Card(
  color: Theme.of(context).colorScheme.secondary,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        // KIRI: INFORMASI PRODUK
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                food.namaMakanan,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Rp ${food.hargaMakanan}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 4),

              Text('Stok: ${food.stockMakanan}'),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // KANAN: TOMBOL
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: editMakanan,
              icon: const Icon(Icons.edit),
              tooltip: 'Edit produk',
            ),

            IconButton(
              onPressed: hapusMakanan,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Hapus produk',
            ),
          ],
        ),
      ],
    ),
  ),
);

  }
}
