import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

import '../state/bloc.dart';
import '../state/events.dart';

class TeacherEditorController {
  static final key = GlobalKey<FormState>();

  TeacherEditorController([String? teacherName]) {
    this.teacherName = teacherName ?? "";
  }

  late String teacherName;
  String email = "";
  String password = "";

  void updateName(String value) {
    teacherName = value;
  }

  void createOrUpdate(Teacher? teacher) {
    final isValid = key.currentState!.validate();

    if (isValid) {
      if (teacher != null) {
        _updateTeacher(teacher);
        NavigationService.pop();
        return;
      }

      _createTeacher();
      NavigationService.pop();
    }
  }

  void _updateTeacher(Teacher teacher) {
    final updatedTeacher = teacher.copyWith(name: Name(teacherName));

    final event = UpdateTeacherEvent(teacher: updatedTeacher);
    final bloc = BlocProvider.of<TeachersBloc>(key.currentContext!);

    final updatedTeacherOption =
        UpdateTeacherOptions(teacher: teacher, schoolId: bloc.state.school.id);
    ServicesProvider.instance()
        .teacherService
        .updateTeacher(updatedTeacherOption);

    bloc.add(event);
  }

  void _createTeacher() {
    final registerUserOption = RegisterUserOptions(
        name: teacherName,
        email: email,
        password: password,
        role: UserRoles.teacher);

    final servicesProvider = ServicesProvider.instance();

    final bloc = BlocProvider.of<TeachersBloc>(key.currentContext!);

    final schoolId = bloc.state.school.id;

    servicesProvider.authService
        .registerUser(options: registerUserOption)
        .then((response) {

      final teacher = Teacher(
        name: Name(teacherName),
        groups: [],
        id: TeacherId(
          response.data?.id.id ?? const Uuid().v4(),
        ),
      );

      final registerOption =
          RegisterTeacherOptions(teacher: teacher, schoolId: schoolId);

      servicesProvider.teacherService.registerTeacher(registerOption);

      final event = CreateTeacherEvent(teacher: teacher);

      bloc.add(event);
    });
  }

  void updateEmail(String value) {
    email = value;
  }

  void updatePassword(String value) {
    password = value;
  }
}
