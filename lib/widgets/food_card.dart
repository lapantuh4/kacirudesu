import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              food.namaMakanan,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Rp ${food.hargaMakanan}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 4),

            Text('Stok: ${food.stockMakanan}'),
          ],
        ),
      ),
    );
  }
}
