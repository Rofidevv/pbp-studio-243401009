List<String> tampilanKeranjang({
    required List<String> barang,
    required Map<String, int> harga,
    bool sedangMemuat = false,
    String? galat,
  }) {
    if (sedangMemuat) {
      return ['Sedang memuat keranjang...'];
    }
    if (galat != null) {
      return ['Gagal memuat: $galat', 'Coba lagi nanti.'];
    }
    if (barang.isEmpty) {
      return ['Keranjang masih kosong.', 'Tambahkan barang untuk mulai berbelanja.'];
    }

    final baris = <String>[];
    var total = 0;
    for (final nama in barang) {
      final hargaBarang = harga[nama] ?? 0;
      total += hargaBarang;
      baris.add('$nama - $hargaBarang');
    }
    baris.add('Total: $total');
    return baris;
  }

  void main() {
    final harga = {'kopi': 8000, 'teh': 5000, 'roti': 15000};

    print('--- memuat ---');
    print(tampilanKeranjang(barang: ['kopi'], harga: harga, sedangMemuat: true).join('\n'));
    print('--- galat ---');
    print(tampilanKeranjang(barang: ['kopi'], harga: harga, galat: 'jaringan putus').join('\n'));
    print('--- kosong ---');
    print(tampilanKeranjang(barang: [], harga: harga).join('\n'));
    print('--- terisi ---');
    print(tampilanKeranjang(barang: ['kopi', 'roti', 'susu'], harga: harga).join('\n'));
  }