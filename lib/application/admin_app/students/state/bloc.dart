import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/students.dart';

import 'events.dart';
import 'state.dart';

class StudentsBloc extends Bloc<StudentEvent, StudentsState> {
  final StudentsAggregate _studentAggregate = StudentsAggregate([]);

  StudentsBloc() : super(StudentsState.initialState()) {
    on<CreateStudentEvent>(_handleCreateStudent);
    on<UpdateStudentEvent>(_handleUpdateStudent);
    on<DeleteStudentEvent>(_handleDeleteStudent);
    on<LoadStudentsEvent>(_handleLoadStudents);
    on<SetGroupEvent>(_handleSetGroup);
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

  FutureOr<void> _handleSetGroup(SetGroupEvent event, Emitter<StudentsState> emit) {
    emit(state.copyWith(group: event.group));
  }
}
