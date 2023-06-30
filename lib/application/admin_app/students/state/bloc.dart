
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class StudentsBloc extends Bloc<StudentEvent,StudentsState>{
  StudentsBloc():super(StudentsState.initialState()){
    on<CreateStudentEvent>(_handleCreateStudent);
    on<UpdateStudentEvent>(_handleUpdateStudent);
    on<DeleteStudentEvent>(_handleDeleteStudent);
    on<LoadStudentsEvent>(_handleLoadStudents);
  }
    

  FutureOr<void> _handleCreateStudent(CreateStudentEvent event, Emitter<StudentsState> emit) {
  }

  FutureOr<void> _handleUpdateStudent(UpdateStudentEvent event, Emitter<StudentsState> emit) {
  }

  FutureOr<void> _handleLoadStudents(LoadStudentsEvent event, Emitter<StudentsState> emit) {
  }

  FutureOr<void> _handleDeleteStudent(DeleteStudentEvent event, Emitter<StudentsState> emit) {
  }
} 