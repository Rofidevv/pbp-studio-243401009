import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guyub/api.dart';
import 'package:guyub/isi_papan.dart';
import 'package:guyub/main.dart';
import 'package:guyub/papan_model.dart';

void main() {
  test('fromJson membaca kode dan penanggung jawab', () {
    final item = ItemBacklog.fromJson({
      'kode': 'GYB-009',
      'judul': 'Uji',
      'jenis': 'bug',
      'poin': 1,
      'status': 'To Do',
      'penanggung_jawab': null,
    });
    expect(item.kode, 'GYB-009');
    expect(item.penanggungJawab, isNull);
  });

  test('muat dari data contoh memberi lima kartu', () async {
    final papan = PapanModel(ambil: ambilContoh);
    await papan.muat();
    expect(papan.items, hasLength(5));
    expect(papan.pesanError, isNull);
  });

  testWidgets('IsiPapan menampilkan kartu dari model', (tester) async {
    final papan = PapanModel(ambil: ambilContoh);
    await papan.muat();
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: IsiPapan(papan: papan))),
    );
    expect(find.text('Halaman menu roti'), findsOneWidget);
  });
}
