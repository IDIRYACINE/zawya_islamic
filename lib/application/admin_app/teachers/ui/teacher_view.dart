import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/admin_app/teachers/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../logic/teacher_card_controller.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherCard({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<TeachersBloc>(context);

    final schoolId =
        BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

    final TeacherCardController controller =
        TeacherCardController(teacher, bloc, schoolId);

    return SizedBox(
      height: 75,
      child: InkWell(
        onTap: controller.onClick,
        child: Center(
          child: ListTile(
            leading: Text(teacher.name.value),
            trailing: OptionsButton(
                onClick: () => controller.onMoreActions(localizations)),
          ),
        ),
      ),
    );
  }
}

class TeachersView extends StatelessWidget {
  const TeachersView({super.key, this.displayAppBar = true});

  final bool displayAppBar;

  Widget _buildItems(BuildContext context, Teacher teacher) {
    return TeacherCard(teacher: teacher);
  }

  void _onAddTeacher() {
    const dialog = TeacherEditorDialog();
    NavigationService.displayDialog(dialog);
  }

  Widget _seperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 20,
    );
  }

  void _loadTeachers(BuildContext context) {
    final teachersBloc = BlocProvider.of<TeachersBloc>(context);

    final schoolId =
        BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

    final teacheroptions = LoadTeachersOptions(schoolId: schoolId);
    ServicesProvider.instance()
        .teacherService
        .getTeachers(teacheroptions)
        .then((res) => teachersBloc.add(LoadTeachersEvent(teachers: res.data)));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    _loadTeachers(context);

    return Scaffold(
      appBar: displayAppBar
          ? AppBar(
              title: Text(localizations.teacherListLabel),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: BlocBuilder<TeachersBloc, TeachersState>(
          builder: (context, state) {
            return ListView.separated(
                separatorBuilder: _seperatorBuilder,
                itemCount: state.teachers.length,
                itemBuilder: (context, index) =>
                    _buildItems(context, state.teachers[index]));
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: ElevatedButton(
          onPressed: _onAddTeacher,
          child: const Icon(AppResources.addIcon),
        ),
      ),
    );
  }
}
