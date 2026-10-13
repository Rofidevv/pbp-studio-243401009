String kartu({
    required String nama,
    required int nilai,
    String? catatan,
    bool tampilkanNilai = true,
  }) {
    final bagianNilai = tampilkanNilai ? ' nilai $nilai' : '';
    final bagianCatatan = catatan == null ? '' : ' ($catatan)';
    return '$nama$bagianNilai$bagianCatatan';
  }

  void main() {
    print(kartu(nama: 'Rofi', nilai: 90));
    print(kartu(nama: 'Rofi', nilai: 90, tampilkanNilai: false));
    print(kartu(nama: 'Rofi', nilai: 90, catatan: 'juara kelas'));
    print(kartu(nama: 'Rofi', nilai: 90, catatan: 'juara kelas', tampilkanNilai: false));
  }