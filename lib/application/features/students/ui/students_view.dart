import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/students/logic/student_card_controller.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/loaded.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/images.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard(
      {super.key, required this.student, required this.controller});

  final StudentCardController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMeasures.cardHeight,
      child: InkWell(
        onTap: () => controller.onClick(student),
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AccentIcon(
                  iconDataAsset: LoadedAppResources.studentWhite,
                ),
                Text(student.name.value),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentsView extends StatelessWidget {
  const StudentsView({super.key, this.displayAppBar = true, this.dataLoader});

  final bool displayAppBar;
  final DataLoaderCallback? dataLoader;

  Widget _buildItems(
      BuildContext context, Student student, StudentCardController controller) {
    final key = Key(student.id.value);

    return Dismissible(
      key: key,
      confirmDismiss: (direction) => controller.onSwipe(student),
      child: StudentCard(
        student: student,
        controller: controller,
      ),
    );
  }

  void _onAddStudent() {
    const dialog = StudentEditorDialog();
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
    final bloc = BlocProvider.of<StudentsBloc>(context);

    final groupId = BlocProvider.of<StudentsBloc>(context).state.group.id;

    final StudentCardController controller =
        StudentCardController(localizations, bloc, groupId);

    dataLoader?.call(context);

    return Scaffold(
      appBar: displayAppBar
          ? AppBar(
              title: Text(localizations.studentListLabel),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<StudentsBloc, StudentsState>(
                builder: (context, state) {
                  if (state.students.isEmpty) {
                    return Center(
                        child: Text(localizations.emptyStudentsListLabel));
                  }

                  return ListView.separated(
                    separatorBuilder: _seperatorBuilder,
                    itemCount: state.students.length,
                    itemBuilder: (context, index) =>
                        _buildItems(context, state.students[index], controller),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddButton(
        onPressed: _onAddStudent,
      ),
    );
  }
}
