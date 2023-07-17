import 'package:zawya_islamic/core/entities/export.dart';

class SessionId {
  final String value;

  SessionId(this.value);
}

class Session {
  final SessionId id;
  final bool isOpen;
  final TeacherId teacherId;

  Session({required this.teacherId,this.isOpen = true, required this.id});
}
