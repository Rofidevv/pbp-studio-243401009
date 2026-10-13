Map<String, num> statistik(List<int> nilai) {
    if (nilai.isEmpty) return {'tertinggi': 0, 'terendah': 0, 'rata': 0.0};

    var tertinggi = nilai.first;
    var terendah = nilai.first;
    var jumlah = 0;
    for (final n in nilai) {
      if (n > tertinggi) tertinggi = n;
      if (n < terendah) terendah = n;
      jumlah += n;
    }
    return {'tertinggi': tertinggi, 'terendah': terendah, 'rata': jumlah / nilai.length};
}

void main() {
  print(statistik([80, 95, 70, 88]));
  print(statistik([]));
}