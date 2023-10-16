import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class StudentsState {
  StudentsState(
      {required this.students,
      required this.presenceAndEvaluation,
      this.session,
      required this.group});

  final List<Student> students;
  final List<StudentEvaluationAndPresence> presenceAndEvaluation;
  final Group group;
  final Session? session;

  factory StudentsState.initialState() {
    return StudentsState(
      session: null,
      presenceAndEvaluation: [],
      students: [],
      group: Group(id: GroupId(""), name: Name("")),
    );
  }

  StudentsState copyWith(
      {List<Student>? students,
      List<StudentEvaluationAndPresence>? presenceAndEvaluation,
      Group? group,
      bool nullifySession = false,
      Session? session}) {
    return StudentsState(
        students: students ?? this.students,
        group: group ?? this.group,
        presenceAndEvaluation:
            presenceAndEvaluation ?? this.presenceAndEvaluation,
        session: nullifySession? null : session ?? this.session );
  }

  List<StudentEvaluationAndPresence> get absence => presenceAndEvaluation
      .where((element) => element.presence.isAbsent)
      .toList();

  List<StudentEvaluationAndPresence> get presence => presenceAndEvaluation
      .where((element) => element.presence.isPresent)
      .toList();
}
