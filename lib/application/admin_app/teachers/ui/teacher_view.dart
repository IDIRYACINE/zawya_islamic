import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/admin_app/teachers/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/loaded.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';
import 'package:zawya_islamic/widgets/images.dart';
import 'package:zawya_islamic/widgets/typography.dart';

import '../logic/teacher_card_controller.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherCard(
      {super.key, required this.teacher, required this.controller});

  final TeacherCardController controller;
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: AppMeasures.cardHeight,
      child: InkWell(
        onTap: () => controller.onClick(context,teacher),
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AccentIcon(
                  iconDataAsset: LoadedAppResources.teacherWhite,
                ),
                Text(teacher.name.value),
               
                  OptionsButton(
                    onClick: () => controller.onMoreActions(teacher),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TeachersView extends StatelessWidget {
  const TeachersView({super.key, this.dataLoader, this.displayAppBar = true});

  final DataLoaderCallback? dataLoader;

  final bool displayAppBar;

  Widget _buildItems(
      BuildContext context, Teacher teacher, TeacherCardController controller) {
    final key = Key(teacher.id.value);

    return Dismissible(
      key: key,
      confirmDismiss: (direction) => controller.onSwipe(teacher, context),
      child: TeacherCard(
        teacher: teacher,
        controller: controller,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final bloc = BlocProvider.of<TeachersBloc>(context);

    final schoolId =
        BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

    final TeacherCardController controller =
        TeacherCardController(localizations, bloc, schoolId);

    dataLoader?.call(context);

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
             if (state.teachers.isEmpty) {
              return Center(child: OnSurfaceText(localizations.emptyTeachersListLabel));
            }
            return ListView.separated(
              separatorBuilder: _seperatorBuilder,
              itemCount: state.teachers.length,
              itemBuilder: (context, index) =>
                  _buildItems(context, state.teachers[index], controller),
            );
          },
        ),
      ),
      floatingActionButton: AddButton(
          onPressed: _onAddTeacher,
        ),
      
    );
  }
}
