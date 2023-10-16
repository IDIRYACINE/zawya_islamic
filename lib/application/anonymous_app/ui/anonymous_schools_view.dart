import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/anonymous_app/logic/controllers.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';

class AnonymousSchoolsView extends StatelessWidget {
  const AnonymousSchoolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolsBloc = BlocProvider.of<SchoolsBloc>(context);
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);

    final AnonymousSchoolCardController controller =
        AnonymousSchoolCardController(schoolsBloc, groupsBloc);

    return SchoolsView(
      controllerPort: controller,
    );
  }
}
