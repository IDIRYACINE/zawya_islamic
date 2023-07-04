import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class PresenceCardController {
  const PresenceCardController(this.studentBloc);

  final StudentsBloc studentBloc;

  void onTap(Student student, bool value) {
    if (value) {
      final event = MarkStudentPresence(student: student);
      studentBloc.add(event);
      return;
    }

    final event = MarkStudentAbsence(student: student);
    studentBloc.add(event);
  }
}
