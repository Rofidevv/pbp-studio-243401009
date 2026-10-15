import 'package:flutter/material.dart';

void main() {
  runApp(const TugasKuliahApp());
}

class TugasKuliahApp extends StatelessWidget {
  const TugasKuliahApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Tugas Kuliah', home: HalamanTugas());
  }
}

class HalamanTugas extends StatelessWidget {
  const HalamanTugas({super.key});
  final List<String> daftarTugas = const [
    'Laporan praktikum PBP',
    'Kuis RPL',
    'Baca modul P05',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Kuliah')),
      body: ListView.builder(
        itemCount: daftarTugas.length,
        itemBuilder: (context, i) => ListTile(title: Text(daftarTugas[i])),
      ),
    );
  }
}
