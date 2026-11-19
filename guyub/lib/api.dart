import 'dart:convert';

import 'package:http/http.dart' as http;

import 'main.dart';

const alamatServer = 'https://guyub.joelmedia.my.id';

// GET /item, lalu setiap objek JSON diubah menjadi ItemBacklog.
Future<List<ItemBacklog>> ambilSemuaItem() async {
  final jawaban = await http.get(Uri.parse('$alamatServer/item'));
  if (jawaban.statusCode != 200) {
    throw Exception('Server menjawab ${jawaban.statusCode}');
  }
  final List<dynamic> data = jsonDecode(jawaban.body);
  return data.map((json) => ItemBacklog.fromJson(json)).toList();
}

// POST /item. Yang dikembalikan kode status, supaya layar bisa memilih pesannya.
Future<int> tambahItem(String judul, int poin) async {
  final jawaban = await http.post(
    Uri.parse('$alamatServer/item'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'judul': judul, 'poin': poin}),
  );
  return jawaban.statusCode;
}

// Cadangan bila server atau Wi-Fi bermasalah: lima kartu tanpa internet.
Future<List<ItemBacklog>> ambilContoh() async => [
  ItemBacklog('GYB-001', 'Halaman menu roti', 'story', 5, 'Done', 'Sekar'),
  ItemBacklog('GYB-002', 'Form pesanan', 'story', 5, 'Review', 'Bayu'),
  ItemBacklog('GYB-003', 'Tombol pesan tidak aktif', 'bug', 2, 'In Progress', 'Dimas'),
  ItemBacklog('GYB-004', 'Ongkir per kecamatan', 'story', 3, 'To Do', 'Bayu'),
  ItemBacklog('GYB-005', 'Foto produk lambat dimuat', 'bug', 2, 'To Do', null),
];
