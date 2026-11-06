import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'data.dart';

void main() => runApp(const MaterialApp(home: LayarDaftar()));

// Tulis semua kode Anda di berkas ini. Kerjakan langkah U1 sampai U6 di SOAL-UTS-PBP.pdf.
// Kode yang belum jalan jadikan komentar (Cmd + / atau Ctrl + /) supaya aplikasi tetap berjalan.

// Contoh U2, membuka layar baru (hapus tanda // bila dipakai):
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => Scaffold(
//       appBar: AppBar(title: Text(kos.nama)),
//       body: Center(child: Text(kos.alamat)),
//     ),
//   ),
// );

// Layar daftar. Sudah StatefulWidget, karena di U5 kos yang terpilih disimpan di sini.
class LayarDaftar extends StatefulWidget {
  const LayarDaftar({super.key});

  @override
  State<LayarDaftar> createState() => _LayarDaftarState();
}

class _LayarDaftarState extends State<LayarDaftar> {
  // U5: kos yang tampil di kanan pada layar lebar.
  Kos dipilih = daftarKos.first;

  String jenisDipilih = 'Semua';

  List<Kos> saring(String jenis) => jenis == 'Semua'
      ? daftarKos
      : daftarKos.where((k) => k.jenis == jenis).toList();

  void bukaDetail(Kos kos) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(kos.nama)),
          body: DetailKos(kos: kos),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tampil = saring(jenisDipilih);
    return Scaffold(
      appBar: AppBar(title: const Text('Kos Sekitar Kampus')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final lebar = constraints.maxWidth >= 600;
          final daftar = Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (final jenis in ['Semua', 'Putra', 'Putri', 'Campur'])
                      ChoiceChip(
                        label: Text(jenis),
                        selected: jenisDipilih == jenis,
                        onSelected: (_) => setState(() {
                          jenisDipilih = jenis;
                          final baru = saring(jenis);
                          if (!baru.contains(dipilih)) dipilih = baru.first;
                        }),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tampil.length,
                  itemBuilder: (context, i) {
                    final kos = tampil[i];
                    return ListTile(
                      leading: Icon(kos.penuh ? Icons.block : Icons.home),
                      iconColor: kos.penuh ? Colors.grey : null,
                      textColor: kos.penuh ? Colors.grey : null,
                      title: Text(kos.nama),
                      subtitle: Text('${kos.jenis} · ${kos.hargaTeks}'),
                      trailing: Text(
                        kos.penuh ? 'Penuh' : '${kos.kamarKosong} kosong',
                      ),
                      onTap: () {
                        if (lebar) {
                          setState(() => dipilih = kos);
                        } else {
                          bukaDetail(kos);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
          if (!lebar) return daftar;
          return Row(
            children: [
              SizedBox(width: 320, child: daftar),
              const VerticalDivider(width: 1),
              Expanded(
                child: DetailKos(key: ValueKey(dipilih.kode), kos: dipilih),
              ),
            ],
          );
        },
      ),
    );
  }
}

// U3 dan U4. Isi layar detail, tanpa Scaffold. Sudah StatefulWidget, karena tombol survei berubah.
class DetailKos extends StatefulWidget {
  const DetailKos({super.key, required this.kos});

  final Kos kos;

  @override
  State<DetailKos> createState() => _DetailKosState();
}

class _DetailKosState extends State<DetailKos> {
  // U4: status tombol survei.
  bool disurvei = false;

  @override
  Widget build(BuildContext context) {
    final kos = widget.kos;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(kos.nama, style: Theme.of(context).textTheme.headlineSmall),
        Text('Kode: ${kos.kode}'),
        Text('Jenis: ${kos.jenis}'),
        Text('Alamat: ${kos.alamat}'),
        Text('Harga: ${kos.hargaTeks}'),
        Text(kos.penuh ? 'Kamar Penuh' : '${kos.kamarKosong} Kamar Kosong'),
        const SizedBox(height: 16),
        const Text('Fasilitas', style: TextStyle(fontWeight: FontWeight.bold)),
        ...kos.fasilitas.map((f) => Text('• $f')),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: kos.penuh
              ? null
              : () => setState(() => disurvei = !disurvei),
          child: Text(disurvei ? 'Sudah disurvei' : 'Tandai sudah disurvei'),
        ),
      ],
    );
  }
}
