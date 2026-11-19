import 'package:flutter/material.dart';
import 'api.dart';

// A1: bungkus MaterialApp di sini.
void main() {
  runApp(const MaterialApp(home: LayarPapan()));
}

// Class ItemBacklog
class ItemBacklog {
  final String kode;
  final String judul;
  final String jenis;
  final int poin;
  String status; // Bisa berubah, dipakai di A4.
  final String? penanggungJawab;

  ItemBacklog(
    this.kode,
    this.judul,
    this.jenis,
    this.poin,
    this.status,
    this.penanggungJawab,
  );

  // Nama di server (penanggung_jawab) boleh berbeda dari nama field di Dart.
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

// A2: FutureBuilder diganti dengan data dari PapanModel.
class LayarPapan extends StatefulWidget {
  const LayarPapan({super.key});

  @override
  State<LayarPapan> createState() => _LayarPapanState();
}

class _LayarPapanState extends State<LayarPapan> {
  late Future<List<ItemBacklog>> muatan = ambilSemuaItem();

  // Form kartu baru, lalu pesan menurut kode status.
  Future<void> bukaFormTambah() async {
    final judul = TextEditingController();
    final poin = TextEditingController();
    final simpan = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kartu baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: judul,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: poin,
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
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (simpan != true) return;

    String pesan;
    try {
      final kode = await tambahItem(judul.text, int.tryParse(poin.text) ?? 0);
      if (kode == 201) {
        pesan = 'Kartu ditambahkan';
        setState(() => muatan = ambilSemuaItem());
      } else if (kode == 422) {
        pesan = 'Judul wajib diisi dan poin paling kecil 1';
      } else {
        pesan = 'Server menjawab $kode';
      }
    } catch (e) {
      pesan = 'Server tidak bisa dihubungi';
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
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
        onPressed: bukaFormTambah,
        tooltip: 'Tambah kartu',
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
        return ListTile(
          title: Text(item.judul),
          subtitle: Text(
            '${item.kode} · ${item.penanggungJawab ?? 'belum ada penanggung jawab'}',
          ),
          trailing: Text(item.status),
          // A3: onTap ditulis di sini.
        );
      },
    );
  }
}
