
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/admin_app/teachers/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

void loadTeachers(BuildContext context) {
  final teachersBloc = BlocProvider.of<TeachersBloc>(context);

  final schoolId =
      BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

  final teacheroptions = LoadTeachersOptions(schoolId: schoolId);
  ServicesProvider.instance()
      .teacherService
      .getTeachers(teacheroptions)
      .then((res) => teachersBloc.add(LoadTeachersEvent(teachers: res.data)));
}

void loadStudents(BuildContext context) {
  final studentsBloc = BlocProvider.of<StudentsBloc>(context);

  final schoolId =
      BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

  final studentOptions = LoadStudentsOptions(schoolId: schoolId);
  ServicesProvider.instance().studentService.getStudents(studentOptions).then(
        (res) {studentsBloc.add(
          LoadStudentsEvent(students: res.data),
        );
        
        }
      );
}

void loadGroups(BuildContext context) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);

  final schoolId =
      BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

  final groupOptions = LoadGroupsOptions(schoolId: schoolId);
  ServicesProvider.instance().groupService.loadGroups(groupOptions).then(
        (res) => groupsBloc.add(
          LoadGroupsEvent(groups: res.data),
        ),
      );
}
