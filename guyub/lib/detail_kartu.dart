import 'package:flutter/material.dart';

import 'main.dart';

const urutanStatus = ['To Do', 'In Progress', 'Review', 'Done'];

class DetailKartu extends StatelessWidget {
  const DetailKartu({super.key, required this.item});

  final ItemBacklog item;

  @override
  Widget build(BuildContext context) {
    // A4: baris context.watch ditulis di sini.
    final posisi = urutanStatus.indexOf(item.status);
    final berikutnya = posisi >= 0 && posisi < urutanStatus.length - 1
        ? urutanStatus[posisi + 1]
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(item.judul)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text('Kode: ${item.kode}'),
            Text('Poin: ${item.poin}'),
            Text('Penanggung jawab: ${item.penanggungJawab ?? 'belum ada'}'),
            Text('Status: ${item.status}'),
            if (berikutnya != null)
              FilledButton(
                onPressed: null, // A4: ganti null.
                child: Text('Pindah ke $berikutnya'),
              ),
            // B1: tombol Selesai ditulis di sini.
          ],
        ),
      ),
    );
  }
}
