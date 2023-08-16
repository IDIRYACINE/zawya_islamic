

abstract class LoggerServicePort {


  Future<void> log(String message, {Object? error, StackTrace? stackTrace});
}