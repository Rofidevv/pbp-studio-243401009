import 'package:flutter/material.dart';

void main() {
  runApp(const TugasKuliahApp());
}

class TugasKuliahApp extends StatelessWidget {
  const TugasKuliahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Kuliah',
      home: Scaffold(
        appBar: AppBar(title: const Text('Tugas Kuliah')),
        body: const Center(child: Text('Belum ada isi')),
      ),
    );
  }
}
