import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/presence.dart';

import '../ui/evaluation_form.dart';

class EvaluationCardController {
  const EvaluationCardController(this.studentBloc);

  final StudentsBloc studentBloc;

  void onTap(StudentEvaluationAndPresence student, bool value) {
   final dialog= EvaluationDialog(student:student);

   NavigationService.displayDialog(dialog);
  }
}
