const Map<String, int> katalog = {
    'kopi': 8000,
    'teh': 5000,
    'jus': 12000,
    'roti': 15000,
    'air': 3000,
  };

  int hargaBarang(String nama) => katalog[nama] ?? 0;

  int totalPesanan(List<String> pesanan) {
    var total = 0;
    for (final nama in pesanan) {
      total += katalog[nama] ?? 0;
    }
    return total;
  }

  void main() {
    print('Harga kopi: ${hargaBarang('kopi')}');
    print('Harga susu (tidak ada): ${hargaBarang('susu')}');
    print('Total pesanan: ${totalPesanan(['kopi', 'roti', 'susu'])}');
  }