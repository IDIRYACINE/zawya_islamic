import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/session.dart';

class StudentsState {
  StudentsState(
      {required this.students,
      required this.unEvaluated,
      required this.evaluations,
      required this.presence,
      this.session,
      required this.group});

  final List<Student> students;
  final List<Student> presence;
  final List<StudentEvaluation> evaluations;
  final List<StudentEvaluation> unEvaluated;
  final Group group;
  final Session? session;

  factory StudentsState.initialState() {
    return StudentsState(
        session: null,
        presence: [],
        students: [],
        evaluations: [],
        group: Group(id: GroupId(""), name: Name("")),
        unEvaluated: []);
  }

  StudentsState copyWith(
      {List<Student>? students,
      List<Student>? presence,
      List<StudentEvaluation>? evaluations,
      List<StudentEvaluation>? unEvaluated,
      Group? group,
      Session? session}) {
    return StudentsState(
        students: students ?? this.students,
        group: group ?? this.group,
        presence: presence ?? this.presence,
        evaluations: evaluations ?? this.evaluations,
        unEvaluated: unEvaluated ?? this.unEvaluated,
        session: session ?? this.session);
  }

  List<Student> get absence =>
      students.where((element) => !presence.contains(element)).toList();
}
