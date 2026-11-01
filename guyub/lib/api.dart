import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

const alamatServer = 'https://guyub.joelmedia.my.id';

Future<List<ItemBacklog>> ambilSemuaItem() async {
  final jawaban = await http.get(Uri.parse('$alamatServer/item'));
  if (jawaban.statusCode != 200) {
    throw Exception('Server menjawab ${jawaban.statusCode}');
  }
  final List<dynamic> data = jsonDecode(jawaban.body);
  return data.map((json) => ItemBacklog.fromJson(json)).toList();
}

Future<int> tambahItem(String judul, int poin) async {
  final jawaban = await http.post(
    Uri.parse('$alamatServer/item'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'judul': judul, 'poin': poin}),
  );
  return jawaban.statusCode;
}