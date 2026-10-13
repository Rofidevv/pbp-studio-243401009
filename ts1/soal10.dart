Map<String, int> bagiTagihan(
    int total,
    List<String> peserta,
    Map<String, int> diskonPersen,
  ) {
    if (peserta.isEmpty) return {};

    final bobot = <String, int>{};
    var totalBobot = 0;
    for (final nama in peserta) {
      final b = 100 - (diskonPersen[nama] ?? 0);
      bobot[nama] = b;
      totalBobot += b;
    }

    final bayaran = <String, int>{};
    var dibayar = 0;
    for (final nama in peserta) {
      final bagian = (total * (bobot[nama] ?? 0)) ~/ totalBobot;
      bayaran[nama] = bagian;
      dibayar += bagian;
    }

    // Sisa pembagian bulat dibebankan ke peserta pertama: dia yang menanggung
    // pembulatan supaya jumlah seluruh bayaran persis sama dengan total.
    final namaSisa = peserta.first;
    bayaran[namaSisa] = (bayaran[namaSisa] ?? 0) + (total - dibayar);

    return bayaran;
  }

  void main() {
    final bayaran = bagiTagihan(100000, ['Rofi', 'Ana', 'Budi'], {'Ana': 10});
    print(bayaran);

    final jumlah = bayaran.values.reduce((a, b) => a + b);
    print('Jumlah bayaran: $jumlah dari total 100000 -> '
        '${jumlah == 100000 ? "utuh" : "tidak utuh"}');

    print('Peserta kosong: ${bagiTagihan(50000, [], {})}');
  }