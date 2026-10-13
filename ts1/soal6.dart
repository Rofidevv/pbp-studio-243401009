Map<String, double> rataRataTiapOrang(Map<String, List<int>> kelas) {
    final hasil = <String, double>{};
    kelas.forEach((nama, nilai) {
      // Daftar kosong dianggap 0 supaya tidak membagi dengan nol.
      hasil[nama] =
          nilai.isEmpty ? 0.0 : nilai.reduce((a, b) => a + b) / nilai.length;
    });
    return hasil;
  }

  String? namaTertinggi(Map<String, List<int>> kelas) {
    final rata = rataRataTiapOrang(kelas);
    if (rata.isEmpty) return null;

    String? terbaik;
    var tertinggi = double.negativeInfinity;
    rata.forEach((nama, nilai) {
      if (nilai > tertinggi) {
        tertinggi = nilai;
        terbaik = nama;
      }
    });
    return terbaik;
  }

  void main() {
    final kelas = {
      'Rofi': [90, 85, 88],
      'Ana': [70, 75, 72],
      'Budi': <int>[],
      'Citra': [95, 92, 98],
    };
    print('Rata-rata: ${rataRataTiapOrang(kelas)}');
    print('Tertinggi: ${namaTertinggi(kelas)}');
    print('Kelas kosong: ${namaTertinggi({})}');
  }