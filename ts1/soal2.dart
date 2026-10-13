double nilaiAkhir(double nts, double nas) => nts * 0.4 + nas * 0.6;

  // Batas huruf: A >= 80, B >= 70, C >= 60, D >= 50, sisanya E.
  String huruf(double nilai) {
    if (nilai >= 80) return 'A';
    if (nilai >= 70) return 'B';
    if (nilai >= 60) return 'C';
    if (nilai >= 50) return 'D';
    return 'E';
  }

  void main() {
    final uji = [
      [90.0, 88.0],
      [75.0, 72.0],
      [60.0, 58.0],
      [40.0, 45.0],
    ];
    for (final pasangan in uji) {
      final na = nilaiAkhir(pasangan[0], pasangan[1]);
      print('NTS ${pasangan[0]}, NAS ${pasangan[1]} -> $na (${huruf(na)})');
    }
  }