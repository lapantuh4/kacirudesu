import 'package:flutter/material.dart';

class AddFoodDialog extends StatefulWidget {
  final void Function(String nama, int harga, int stok) onSimpan;

  const AddFoodDialog({super.key, required this.onSimpan});

  @override
  State<AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  late final namaController = TextEditingController();
  late final hargaController = TextEditingController();
  late final stokController = TextEditingController();

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
                    content: Text('Periksa kembali input produk!'),
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
