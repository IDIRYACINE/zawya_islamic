
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class TeachersBloc extends Bloc<TeacherEvent,TeachersState>{
  TeachersBloc():super(TeachersState.initialState()){
    on<CreateTeacherEvent>(_handleCreateTeacher);
    on<UpdateTeacherEvent>(_handleUpdateTeacher);
    on<DeleteTeacherEvent>(_handleDeleteTeacher);
    on<LoadTeachersEvent>(_handleLoadTeachers);
  }
    

  FutureOr<void> _handleCreateTeacher(CreateTeacherEvent event, Emitter<TeachersState> emit) {
  }

  FutureOr<void> _handleUpdateTeacher(UpdateTeacherEvent event, Emitter<TeachersState> emit) {
  }

  FutureOr<void> _handleLoadTeachers(LoadTeachersEvent event, Emitter<TeachersState> emit) {
  }

  FutureOr<void> _handleDeleteTeacher(DeleteTeacherEvent event, Emitter<TeachersState> emit) {
  }
} 