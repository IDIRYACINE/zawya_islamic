class Ayat {
  final int number;

  Ayat._(this.number);

  static Ayat? fromNumber(int num, int surahAyatCount) {
    if (num < 1 || num > surahAyatCount) {
      return null;
    }

    return Ayat._(num);
  }
}

class Surat {
  final String name;
  final int ayatCount;
  final int suratNumber;

  Surat(
      {required this.suratNumber, required this.name, required this.ayatCount});
}
