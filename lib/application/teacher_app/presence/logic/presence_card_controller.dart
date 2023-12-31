import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/presence.dart';

class PresenceCardController {
  const PresenceCardController(this.studentBloc);

  final StudentsBloc studentBloc;

  void onTap(StudentEvaluationAndPresence student) {
    final isPresent = student.presence.isPresent;

    if (isPresent) {
      final event = MarkStudentAbsenceEvent(evaluation: student);
      studentBloc.add(event);
      return;
    }

    final event = MarkStudentPresenceEvent(evaluation: student);
    studentBloc.add(event);
  }
}
