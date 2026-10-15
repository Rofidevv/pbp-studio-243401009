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

class HalamanTugas extends StatefulWidget {
  const HalamanTugas({super.key});
  @override
  State<HalamanTugas> createState() => _HalamanTugasState();
}

class _HalamanTugasState extends State<HalamanTugas> {
  final List<String> daftarTugas = [
    'Laporan praktikum PBP',
    'Kuis RPL',
    'Baca modul P05',
  ];
  final TextEditingController isian = TextEditingController();
  void tambahTugas() {
    if (isian.text.isEmpty) return;
    setState(() {
      daftarTugas.add(isian.text);
    });
    isian.clear();
  }

  void hapusTugas(int i) {
    setState(() {
      daftarTugas.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Kuliah')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: isian,
                    decoration: const InputDecoration(hintText: 'Tugas baru'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: tambahTugas,
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: daftarTugas.isEmpty
                ? const Center(child: Text('Belum ada tugas'))
                : ListView.builder(
                    itemCount: daftarTugas.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(child: Text(daftarTugas[i])),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => hapusTugas(i),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
