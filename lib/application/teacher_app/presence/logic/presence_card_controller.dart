import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/presence.dart';

class PresenceCardController {
  const PresenceCardController(this.studentBloc);

  final StudentsBloc studentBloc;

  void onTap(StudentEvaluationAndPresence student) {
    final isAbsent = student.presence.isAbsent;
    if (isAbsent) {
      final event = MarkStudentPresence(evaluation: student);
      studentBloc.add(event);
      return;
    }

    final event = MarkStudentAbsence(evaluation: student);
    studentBloc.add(event);
  }
}
