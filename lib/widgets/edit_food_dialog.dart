import 'package:flutter/material.dart';
import 'package:kaciru_desu/models/food.dart';

class EditFoodDialog extends StatefulWidget {
  final Food food;
  final void Function(String nama, int harga, int stok) onSimpan;

  const new({super.key, required this.food, required this.onSimpan});

  @override
  State<EditFoodDialog> createState() => _EditFoodDialogState();
}

class _EditFoodDialogState extends State<EditFoodDialog> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
