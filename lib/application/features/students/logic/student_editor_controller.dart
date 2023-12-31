import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

import '../state/bloc.dart';
import '../state/events.dart';

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
    final isValid = _validateData();

    if (isValid) {
      if (student != null) {
        _updateStudent(student);
        NavigationService.pop();
        return;
      }

      _createStudent();
      NavigationService.pop();
    }
  }

  void _updateStudent(Student student) {

    final updatedStudent = student.copyWith(
        name: Name(studentName),
        birthDate: BirthDate(birthDate),
        );

    final bloc = BlocProvider.of<StudentsBloc>(key.currentContext!);

    final options =
        UpdateStudentOptions(student: updatedStudent);

    final servicesProvider = ServicesProvider.instance();

    servicesProvider.studentService.updateStudent(options).then(
          (value) => bloc.add(
            UpdateStudentEvent(student: updatedStudent),
          ),
        );

  }

  void _createStudent() {
    final schoolId = BlocProvider.of<SchoolsBloc>(key.currentContext!)
        .state
        .selectedSchool!
        .id;

    final student = Student(
      schoolId: schoolId,
      name: Name(studentName),
      id: StudentId(const Uuid().v4()),
      birthDate: BirthDate(birthDate),
    );

    final bloc = BlocProvider.of<StudentsBloc>(key.currentContext!);

    final options = RegisterStudentOptions(student: student);

    final servicesProvider = ServicesProvider.instance();
    servicesProvider.studentService.registerStudent(options).then((value) {
      bloc.add(
        CreateStudentEvent(student: student),
      );
      
    });
  }


  bool _validateData() {
    return key.currentState!.validate() ;
  }
}
