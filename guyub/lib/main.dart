import 'package:flutter/material.dart';

import 'api.dart';

void main() {
  runApp(const MaterialApp(home: LayarGuyub()));
}

class ItemBacklog {
  final String kode;
  final String judul;
  final String jenis;
  final int poin;
  final String status;
  final String? penanggung_jawab;

  const ItemBacklog(
    this.kode,
    this.judul,
    this.jenis,
    this.poin,
    this.status,
    this.penanggung_jawab,
  );
  factory ItemBacklog.fromJson(Map<String, dynamic> json) {
    return ItemBacklog(
      json['kode'],
      json['judul'],
      json['jenis'],
      json['poin'],
      json['status'],
      json['penanggung_jawab'],
    );
  }
}

// const daftarItem = [
//   ItemBacklog('GYB-001', 'Halaman menu roti', 'story', 5, 'Done', 'Sekar'),
//   ItemBacklog('GYB-002', 'Form pesanan', 'story', 5, 'Review', 'Bayu'),
//   ItemBacklog(
//     'GYB-003',
//     'Tombol pesan tidak aktif di Safari',
//     'bug',
//     2,
//     'In Progress',
//     'Dimas',
//   ),
//   ItemBacklog(
//     'GYB-004',
//     'Ongkir dihitung per kecamatan',
//     'story',
//     3,
//     'To Do',
//     'Bayu',
//   ),
//   ItemBacklog('GYB-005', 'Foto produk lambat dimuat', 'bug', 2, 'To Do', null),
// ];

const urutanStatus = ['To Do', 'In Progress', 'Review', 'Done'];

class LayarGuyub extends StatefulWidget {
  const LayarGuyub({super.key});

  @override
  State<LayarGuyub> createState() => _LayarGuyubState();
}

class _LayarGuyubState extends State<LayarGuyub> {
  late Future<List<ItemBacklog>> muatan = ambilSemuaItem();

  Future<void> bukaFormTambah() async {
    final teksJudul = TextEditingController();
    final teksPoin = TextEditingController();

    final simpan = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kartu baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: teksJudul,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: teksPoin,
              decoration: const InputDecoration(labelText: 'Poin'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    final judul = teksJudul.text;
    final poin = int.tryParse(teksPoin.text) ?? 0;
    teksJudul.dispose();
    teksPoin.dispose();

    if (simpan != true) return;

    final kode = await tambahItem(judul, poin);
    if (!mounted) return;
    if (kode == 201) {
      setState(() => muatan = ambilSemuaItem());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guyub')),
      body: FutureBuilder<List<ItemBacklog>>(
        future: muatan,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat: ${snapshot.error}'));
          }
          return DaftarKartu(items: snapshot.data!);
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah kartu',
        onPressed: bukaFormTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DaftarKartu extends StatelessWidget {
  const DaftarKartu({super.key, required this.items});

  final List<ItemBacklog> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        return Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: ListTile(
            title: Text(item.judul),
            subtitle: Text(
              '${item.kode} - ${item.penanggung_jawab ?? 'belum ada penanggung jawab'}  ${item.status}',
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailKartu(item: item)),
            ),
          ),
        );
      },
    );
  }
}

class DetailKartu extends StatefulWidget {
  const DetailKartu({super.key, required this.item});
  final ItemBacklog item;

  @override
  State<DetailKartu> createState() => _DetailKartuState();
}

class _DetailKartuState extends State<DetailKartu> {
  late String status = widget.item.status;

  @override
  Widget build(BuildContext context) {
    final sdhDone = status == 'Done';
    final tnpPenangungJawab = widget.item.penanggung_jawab == null;
    final labelTombol = sdhDone
        ? 'Sudah Done'
        : 'Pindah ke ${urutanStatus[urutanStatus.indexOf(status) + 1]}';

    return Scaffold(
      appBar: AppBar(title: Text(widget.item.kode)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.judul),
            Text(
              '${widget.item.kode} . ${widget.item.jenis} . '
              '${widget.item.poin} poin',
            ),
            Text(
              'Penangung Jawab: '
              '${widget.item.penanggung_jawab ?? 'belum ada penangung jawab'}',
            ),
            Text('Status: $status'),
            ElevatedButton(
              onPressed: (sdhDone || tnpPenangungJawab)
                  ? null
                  : () {
                      setState(() {
                        status = urutanStatus[urutanStatus.indexOf(status) + 1];
                      });
                    },
              child: Text(labelTombol),
            ),
            if (tnpPenangungJawab)
              Text('Kartu tanpa penangung jawab tidak bisa dipindahk'),
          ],
        ),
      ),
    );
  }
}
