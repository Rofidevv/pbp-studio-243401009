import 'package:flutter/material.dart';

import 'main.dart';
import 'papan_model.dart';

// Isi layar papan: memuat, error, atau daftar kartu.
class IsiPapan extends StatelessWidget {
  const IsiPapan({super.key, required this.papan});

  final PapanModel papan;

  @override
  Widget build(BuildContext context) {
    if (papan.sedangMuat) {
      return const Center(child: CircularProgressIndicator());
    }
    if (papan.pesanError != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(papan.pesanError!),
            TextButton(onPressed: papan.muat, child: const Text('Coba lagi')),
          ],
        ),
      );
    }
    return DaftarKartu(items: papan.items);
  }
}
