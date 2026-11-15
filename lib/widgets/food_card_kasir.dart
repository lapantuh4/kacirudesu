
import 'package:flutter/material.dart';
import '../models/food.dart';

class FoodCardKasir extends StatelessWidget {
  final Food food;
  final VoidCallback onTambah;

  const FoodCardKasir({
    super.key,
    required this.food,
    required this.onTambah,
  });

  @override
  Widget build(BuildContext context) {
    final stokHabis = food.stockMakanan <= 0;

    return Card(
      color: Theme.of(context).colorScheme.secondary,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: stokHabis ? null : onTambah,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.fastfood,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 10),
              Text(
                food.namaMakanan,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
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
              Text(
                stokHabis ? 'Stok habis' : 'Stok: ${food.stockMakanan}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
