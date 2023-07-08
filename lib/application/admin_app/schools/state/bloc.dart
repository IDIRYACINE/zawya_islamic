import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'events.dart';
import 'state.dart';

class SchoolsBloc extends Bloc<SchoolEvent, SchoolState> {
  final SchoolsAggregate _aggreagate = SchoolsAggregate([]);

  SchoolsBloc() : super(SchoolState.initialState()) {
    on<CreateSchoolEvent>(_handleCreateSchool);
    on<UpdateSchoolEvent>(_handleUpdateSchool);
    on<DeleteSchoolEvent>(_handleDeleteSchool);
    on<LoadSchoolsEvent>(_handleLoadSchools);
    on<SelectSchoolEvent>(_handleSelectSchool);
  }

  FutureOr<void> _handleCreateSchool(
      CreateSchoolEvent event, Emitter<SchoolState> emit) {
    final schools = _aggreagate.addSchool(event.school);
    emit(state.copyWith(schools: schools));
  }

  FutureOr<void> _handleUpdateSchool(
      UpdateSchoolEvent event, Emitter<SchoolState> emit) {
    final schools = _aggreagate.updateSchool(event.school);
    emit(state.copyWith(schools: schools));
  }

  FutureOr<void> _handleLoadSchools(
      LoadSchoolsEvent event, Emitter<SchoolState> emit) {
    final schools = _aggreagate.setSchools(event.schools);
    emit(state.copyWith(schools: schools));
  }

  FutureOr<void> _handleDeleteSchool(
      DeleteSchoolEvent event, Emitter<SchoolState> emit) {
    final schools = _aggreagate.deleteSchool(event.school);
    emit(state.copyWith(schools: schools));
  }

  FutureOr<void> _handleSelectSchool(
      SelectSchoolEvent event, Emitter<SchoolState> emit) {
    emit(state.copyWith(selectedSchool: event.school));
  }
}
