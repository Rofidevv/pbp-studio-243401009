import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: LayarGuyub()));
}

class ItemBacklog {
  final String code;
  final String judul;
  final String jenis;
  final int poin;
  final String status;
  final String? penanggungjawab;

  const ItemBacklog(
    this.code,
    this.judul,
    this.jenis,
    this.poin,
    this.status,
    this.penanggungjawab,
  );
}

const daftarItem = [
  ItemBacklog('GYB-001', 'Halaman menu roti', 'story', 5, 'Done', 'Sekar'),
  ItemBacklog('GYB-002', 'Form pesanan', 'story', 5, 'Review', 'Bayu'),
  ItemBacklog(
    'GYB-003',
    'Tombol pesan tidak aktif di Safari',
    'bug',
    2,
    'In Progress',
    'Dimas',
  ),
  ItemBacklog(
    'GYB-004',
    'Ongkir dihitung per kecamatan',
    'story',
    3,
    'To Do',
    'Bayu',
  ),
  ItemBacklog('GYB-005', 'Foto produk lambat dimuat', 'bug', 2, 'To Do', null),
];

class LayarGuyub extends StatelessWidget {
  const LayarGuyub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guyub")),
      body: DaftarKartu(),
    );
  }
}

class DaftarKartu extends StatelessWidget {
  const DaftarKartu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daftarItem.length,
      itemBuilder: (context, i) {
        final item = daftarItem[i];
        return Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: ListTile(
            title: Text(item.judul),
            subtitle: Text('${item.code} - ${item.penanggungjawab ?? 'belum ada penanggung jawab'}  ${item.status}'),
          ),
        );
      },
    );
  }
}
