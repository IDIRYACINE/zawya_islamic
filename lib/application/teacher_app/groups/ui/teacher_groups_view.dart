

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';

import '../logic/teacher_groups_controller.dart';

class TeacherGroupsView extends StatelessWidget{
  const TeacherGroupsView({super.key});

  @override
  Widget build(BuildContext context) {

    final studentBloc = BlocProvider.of<StudentsBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);

    return  GroupsView(
        displayAppBar: true,
        displayFloatingAction: false,
        controllerPort: TeacherGroupsController(studentBloc,appBloc)
    );
  }

}