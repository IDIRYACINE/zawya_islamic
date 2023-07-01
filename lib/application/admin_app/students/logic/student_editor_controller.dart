import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';

import '../state/bloc.dart';
import '../state/events.dart';

//TODO : make call to infrastructure

class StudentEditorController {
  static final key = GlobalKey<FormState>();

  StudentEditorController([Student? student]) {
    studentName = student?.name.value ?? "";
    birthDate = student?.birthDate.date ?? DateTime.now();
  }

  late String studentName;
  late DateTime birthDate;

  void updateName(String value) {
    studentName = value;
  }

  void updateBirthDate(DateTime value) {
    birthDate = value;
  }

  void createOrUpdate(Student? student) {
    final isValid = key.currentState!.validate();

    if (isValid) {
      if (student != null) {
        _updateStudent(student);
        return;
      }

      _createStudent();
    }
  }

  void _updateStudent(Student student) {
    final updatedStudent = student.copyWith(name: Name(studentName));

    final event = UpdateStudentEvent(student: updatedStudent);
    final bloc = BlocProvider.of<StudentsBloc>(key.currentContext!);

    bloc.add(event);
  }

  void _createStudent() {
    final student = Student(
      name: Name(studentName),
      id: StudentId(const Uuid().v4()),
      birthDate: BirthDate(birthDate),
    );

    final bloc = BlocProvider.of<StudentsBloc>(key.currentContext!);

    final event = CreateStudentEvent(student: student);

    bloc.add(event);
  }
}
