


class AyatException implements Exception {
  final String message = "ayat doesn't exist";

  AyatException();

  @override
  String toString() {
    return 'AyatException: $message';
  }
}