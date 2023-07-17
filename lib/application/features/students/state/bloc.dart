import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/students.dart';

import 'events.dart';
import 'state.dart';

class StudentsBloc extends Bloc<StudentEvent, StudentsState> {
  final StudentsAggregate _studentAggregate = StudentsAggregate([]);
  final StudentEvaluationsAggregate _evaluationAggregate =
      StudentEvaluationsAggregate([]);

  StudentsBloc() : super(StudentsState.initialState()) {
    on<CreateStudentEvent>(_handleCreateStudent);
    on<UpdateStudentEvent>(_handleUpdateStudent);
    on<DeleteStudentEvent>(_handleDeleteStudent);
    on<LoadStudentsEvent>(_handleLoadStudents);
    on<SetGroupEvent>(_handleSetGroup);
    on<MarkStudentAbsence>(_handleMarkStudentAbsence);
    on<MarkStudentPresence>(_handleMarkStudentPresence);
    on<MarkStudentEvaluation>(_handleMarkEvaluation);
    on<UnMarkStudentEvaluation>(_handleUnMarkEvaluation);
  }

  FutureOr<void> _handleCreateStudent(
      CreateStudentEvent event, Emitter<StudentsState> emit) {
    final updatedStudents = _studentAggregate.addStudent(event.student);
    emit(state.copyWith(students: updatedStudents));
  }

  FutureOr<void> _handleUpdateStudent(
      UpdateStudentEvent event, Emitter<StudentsState> emit) {
    final updatedStudents = _studentAggregate.updateStudent(event.student);
    emit(state.copyWith(students: updatedStudents));
  }

  FutureOr<void> _handleLoadStudents(
      LoadStudentsEvent event, Emitter<StudentsState> emit) {
    final updatedStudents = _studentAggregate.setStudents(event.students);
    emit(state.copyWith(students: updatedStudents));
  }

  FutureOr<void> _handleDeleteStudent(
      DeleteStudentEvent event, Emitter<StudentsState> emit) {
    final updatedStudents = _studentAggregate.deleteStudent(event.student);
    emit(state.copyWith(students: updatedStudents));
  }

  FutureOr<void> _handleSetGroup(
      SetGroupEvent event, Emitter<StudentsState> emit) {
    emit(state.copyWith(group: event.group));
  }

  FutureOr<void> _handleMarkStudentAbsence(
      MarkStudentAbsence event, Emitter<StudentsState> emit) {
    final presence =
        _studentAggregate.deleteStudent(event.student, state.presence);


    emit(state.copyWith(presence: presence,));
  }

  FutureOr<void> _handleMarkStudentPresence(
      MarkStudentPresence event, Emitter<StudentsState> emit) {

    final presence =
        _studentAggregate.addStudent(event.student, state.presence);




    emit(state.copyWith(presence: presence));
  }

  FutureOr<void> _handleMarkEvaluation(
      MarkStudentEvaluation event, Emitter<StudentsState> emit) {

    final updatedEvaluations =
        _evaluationAggregate.addStudentEvaluation(event.evaluation);

    final updatedUnEvaluated = _evaluationAggregate.deleteStudentEvaluation(
        event.evaluation, state.unEvaluated);

    emit(state.copyWith(
        evaluations: updatedEvaluations, unEvaluated: updatedUnEvaluated));
  }

  FutureOr<void> _handleUnMarkEvaluation(
      UnMarkStudentEvaluation event, Emitter<StudentsState> emit) {

  final updatedEvaluations =
        _evaluationAggregate.deleteStudentEvaluation(event.evaluation,state.unEvaluated);
        
    final updatedUnEvaluated = _evaluationAggregate.addStudentEvaluation(
        event.evaluation);

    emit(state.copyWith(
        evaluations: updatedEvaluations, unEvaluated: updatedUnEvaluated));
  }
}
