import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';

import '../state/bloc.dart';
import '../state/events.dart';

//TODO : make call to infrastructure

class TeacherEditorController {
  static final key = GlobalKey<FormState>();

  TeacherEditorController([String? teacherName]) {
    this.teacherName = teacherName ?? "";
  }

  late String teacherName;

  void updateName(String value) {
    teacherName = value;
  }

  void createOrUpdate(Teacher? teacher) {
    final isValid = key.currentState!.validate();

    if (isValid) {
      if (teacher != null) {
        _updateTeacher(teacher);
        return;
      }

      _createTeacher();
    }
  }


  void _updateTeacher(Teacher teacher){
    final updatedTeacher = teacher.copyWith(
      name: Name(teacherName)
    );

    final event = UpdateTeacherEvent(teacher: updatedTeacher);
    final bloc = BlocProvider.of<TeachersBloc>(key.currentContext!);
    
    bloc.add(event);
  }

  void _createTeacher(){
    final teacher = Teacher(name: Name(teacherName),groups: [], id: TeacherId(const Uuid().v4())) ;
    final bloc = BlocProvider.of<TeachersBloc>(key.currentContext!);

    final event = CreateTeacherEvent(teacher: teacher);

    bloc.add(event);

  }
}
