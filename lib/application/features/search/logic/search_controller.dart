import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

class StudentSearchController {
  late StudentsBloc _studentsBloc;
  late SchoolsBloc _schoolsBloc;
  late AppLocalizations _localizations;
  String? _studentName;

  StudentSearchController(BuildContext context) {
    _studentsBloc = BlocProvider.of<StudentsBloc>(context);
    _schoolsBloc = BlocProvider.of<SchoolsBloc>(context);
    _localizations = AppLocalizations.of(context)!;
  }

  void updateStudentName(String? name) {
    _studentName = name;
  }

  void searchStudent() {
    if (_studentName == null || _studentName == '') {
      NavigationService.displayDialog(
          InfoDialog(message: _localizations.emptyFieldError));
    }

    final schoolId = _schoolsBloc.state.selectedSchool!.id;

    final searchOptions =
        SearchStudentOptions(studentName: _studentName!, schoolId: schoolId);
    ServicesProvider.instance()
        .studentService
        .searchStudent(searchOptions)
        .then((res) {
      final event = LoadPresencesAndEvaluations(evaluations: res.data);
      _studentsBloc.add(event);
    });
  }
}
