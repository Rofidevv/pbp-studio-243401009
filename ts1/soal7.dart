String? periksaNim(String nim, {int tahunSekarang = 2026}) {
    if (nim.length != 7) {
      return 'panjang NIM harus tujuh angka, bukan ${nim.length}';
    }
    if (RegExp(r'[A-Za-z]').hasMatch(nim)) {
      return 'NIM tidak boleh mengandung huruf: $nim';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(nim)) {
      return 'NIM hanya boleh berisi angka: $nim';
    }
    final tahun = int.parse(nim.substring(0, 4));
    if (tahun < 2015 || tahun > tahunSekarang) {
      return 'tahun masuk $tahun di luar 2015 sampai $tahunSekarang';
    }
    return null;
  }

  void main() {
    for (final nim in ['202400', '2024A01', '2010010', '2030010', '2024001']) {
      print('$nim -> ${periksaNim(nim) ?? "sah"}');
    }
  }