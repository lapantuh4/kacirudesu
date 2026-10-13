import 'package:flutter/material.dart';

import '../models/food.dart';

class EditFoodDialog extends StatefulWidget {
  final Food food;
  final void Function(String nama, int harga, int stok) onSimpan;

  const EditFoodDialog({super.key, required this.food, required this.onSimpan});

  @override
  State<EditFoodDialog> createState() => _EditFoodDialogState();
}

class _EditFoodDialogState extends State<EditFoodDialog> {
  late final namaController = TextEditingController(
    text: widget.food.namaMakanan,
  );

  late final hargaController = TextEditingController(
    text: '${widget.food.hargaMakanan}',
  );

  late final stokController = TextEditingController(
    text: '${widget.food.stockMakanan}',
  );

  @override
  void dispose() {
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Edit Produk',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Theme.of(context).textTheme.displayLarge?.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            final nama = namaController.text.trim();
            final harga = int.tryParse(hargaController.text);
            final stok = int.tryParse(stokController.text);

            if (nama.isEmpty || harga == null || stok == null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Nama, harga, dan stok harus diisi dengan benar!',
                    ),
                    duration: Duration(seconds: 4),
                  ),
                );

              return;
            }

            widget.onSimpan(nama, harga, stok);
            Navigator.pop(context);
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
