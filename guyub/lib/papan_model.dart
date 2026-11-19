import 'package:flutter/foundation.dart';

import 'api.dart';
import 'main.dart';

typedef AmbilItem = Future<List<ItemBacklog>> Function();

// Data papan disimpan di sini supaya bisa dipakai beberapa layar.
class PapanModel extends ChangeNotifier {
  PapanModel({this.ambil = ambilSemuaItem});

  final AmbilItem ambil;

  List<ItemBacklog> _items = [];
  bool _sedangMuat = false;
  String? _pesanError;

  List<ItemBacklog> get items => _items;
  bool get sedangMuat => _sedangMuat;
  String? get pesanError => _pesanError;

  Future<void> muat() async {
    _sedangMuat = true;
    _pesanError = null;
    notifyListeners();
    try {
      _items = await ambil();
    } catch (e) {
      _pesanError = 'Server tidak bisa dihubungi';
    }
    _sedangMuat = false;
    notifyListeners();
  }

  void ubahStatus(String kode, String statusBaru) {
    // A4: tulis di sini.
  }
}
