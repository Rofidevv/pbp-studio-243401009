const Map<String, int> katalogHarga = {
    'kopi': 8000,
    'teh': 5000,
    'roti': 15000,
  };

  Map<String, Object> tanganiPermintaan(Map<String, String> kueri) {
    final barang = kueri['barang'];
    if (barang == null || barang.isEmpty) {
      return {'status': 400, 'pesan': 'parameter barang wajib diisi'};
    }

    final jumlahTeks = kueri['jumlah'];
    var jumlah = 1;
    if (jumlahTeks != null) {
      final angka = int.tryParse(jumlahTeks);
      if (angka == null) {
        return {'status': 400, 'pesan': 'jumlah "$jumlahTeks" bukan angka'};
      }
      jumlah = angka;
    }
    if (jumlah < 1) {
      return {'status': 400, 'pesan': 'jumlah harus minimal 1'};
    }
                          
    final harga = katalogHarga[barang];
    if (harga == null) {
      return {'status': 404, 'pesan': 'barang "$barang" tidak ada di katalog'};
    }

    return {
      'status': 200,
      'barang': barang,
      'jumlah': jumlah,
      'total': harga * jumlah,
    };
  }

  void main() {
    final uji = <Map<String, String>>[
      {'jumlah': '2'},
      {'barang': '', 'jumlah': '2'},
      {'barang': 'kopi', 'jumlah': 'dua'},
      {'barang': 'kopi', 'jumlah': '0'},
      {'barang': 'susu', 'jumlah': '2'},
      {'barang': 'kopi', 'jumlah': '3'},
    ];
    for (final kueri in uji) {
      print('$kueri -> ${tanganiPermintaan(kueri)}');
    }
    print('tanpa jumlah -> ${tanganiPermintaan({'barang': 'teh'})}');
  }