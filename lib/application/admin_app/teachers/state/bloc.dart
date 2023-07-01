import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/teacher.dart';

import 'events.dart';
import 'state.dart';

class TeachersBloc extends Bloc<TeacherEvent, TeachersState> {
  final TeachersAggregate _aggregate = TeachersAggregate([]);

  TeachersBloc() : super(TeachersState.initialState()) {
    on<CreateTeacherEvent>(_handleCreateTeacher);
    on<UpdateTeacherEvent>(_handleUpdateTeacher);
    on<DeleteTeacherEvent>(_handleDeleteTeacher);
    on<LoadTeachersEvent>(_handleLoadTeachers);
    on<SetSchoolEvent>(_handleSetSchool);
  }

  FutureOr<void> _handleCreateTeacher(
      CreateTeacherEvent event, Emitter<TeachersState> emit) {
    final updatedTeachers = _aggregate.addTeacher(event.teacher);
    emit(state.copyWith(teachers: updatedTeachers));
  }

  FutureOr<void> _handleUpdateTeacher(
      UpdateTeacherEvent event, Emitter<TeachersState> emit) {
    final updatedTeachers = _aggregate.updateTeacher(event.teacher);
    emit(state.copyWith(teachers: updatedTeachers));
  }

  FutureOr<void> _handleLoadTeachers(
      LoadTeachersEvent event, Emitter<TeachersState> emit) {
    final updatedTeachers = _aggregate.setTeachers(event.teachers);
    emit(state.copyWith(teachers: updatedTeachers));
  }

  FutureOr<void> _handleDeleteTeacher(
      DeleteTeacherEvent event, Emitter<TeachersState> emit) {
    final updatedTeachers = _aggregate.deleteTeacher(event.teacher);
    emit(state.copyWith(teachers: updatedTeachers));
  }

  FutureOr<void> _handleSetSchool(
      SetSchoolEvent event, Emitter<TeachersState> emit) {
    emit(state.copyWith(school: event.school));
  }
}
