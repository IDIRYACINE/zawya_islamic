import "dart:developer" as dev;

import "package:zawya_islamic/infrastructure/ports/logger_port.dart";

class LoggerService implements LoggerServicePort {
  static const _appTag = "idir@zawya";

  @override
  Future<void> log(String message,
     { Object? error, StackTrace? stackTrace}) async {
    dev.log(message, name: _appTag, error: error, stackTrace: stackTrace);
  }
}
