import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/students.dart';
import 'package:zawya_islamic/core/entities/export.dart';

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
    on<SetSession>(_handleSession);
    on<LoadPresencesAndEvaluations>(_handleLoadPresencesAndEvaluations);
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
    final updatedEvaluation = event.evaluation.copyWith(
        presence: event.evaluation.presence
            .copyWith(currentSessionPresence: PresenceType.absent));

    final presence =
        _evaluationAggregate.updateStudentEvaluation(updatedEvaluation);

    emit(state.copyWith(
      presenceAndEvaluation: presence,
    ));
  }

  FutureOr<void> _handleMarkStudentPresence(
      MarkStudentPresence event, Emitter<StudentsState> emit) {
        
 final updatedEvaluation = event.evaluation.copyWith(
        presence: event.evaluation.presence
            .copyWith(currentSessionPresence: PresenceType.present));

    final presence =
        _evaluationAggregate.updateStudentEvaluation(updatedEvaluation);

    emit(state.copyWith(presenceAndEvaluation: presence));
  }

  FutureOr<void> _handleMarkEvaluation(
      MarkStudentEvaluation event, Emitter<StudentsState> emit) {


    final updatedEvaluations =
        _evaluationAggregate.updateStudentEvaluation(event.evaluation);

    emit(state.copyWith(presenceAndEvaluation: updatedEvaluations));
  }

  FutureOr<void> _handleUnMarkEvaluation(
      UnMarkStudentEvaluation event, Emitter<StudentsState> emit) {
    final updatedEvaluations =
        _evaluationAggregate.updateStudentEvaluation(event.evaluation);

    emit(state.copyWith(
      presenceAndEvaluation: updatedEvaluations,
    ));
  }

  FutureOr<void> _handleSession(SetSession event, Emitter<StudentsState> emit) {

    List<StudentEvaluationAndPresence>? updatedPresence;
    if(event.nullify){
     updatedPresence = _evaluationAggregate.updateAllByPresence();

    }

    emit(state.copyWith(
      session: event.session,
      nullifySession: event.nullify,
      presenceAndEvaluation: updatedPresence
      ));
  }

  FutureOr<void> _handleLoadPresencesAndEvaluations(
      LoadPresencesAndEvaluations event, Emitter<StudentsState> emit) {
    _evaluationAggregate.setStudentEvaluations(event.evaluations);

    emit(state.copyWith(presenceAndEvaluation: event.evaluations));
  }
}
