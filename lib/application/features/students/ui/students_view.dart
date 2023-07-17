import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/features/students/logic/student_card_controller.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';


class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<StudentsBloc>(context);
    
    final schoolId =
        BlocProvider.of<SchoolsBloc>(context).state.selectedSchool!.id;

    final StudentCardController controller =
        StudentCardController(student, bloc, schoolId);

    return SizedBox(
      height: 75,
      child: InkWell(
        onTap: controller.onClick,
        child: Center(
          child: ListTile(
            leading: Text(student.name.value),
            trailing: OptionsButton(
                onClick: () => controller.onMoreActions(localizations)),
          ),
        ),
      ),
    );
  }
}

class StudentsView extends StatelessWidget {
  const StudentsView({super.key, this.displayAppBar = true, required this.dataLoader});

  final bool displayAppBar;
  final DataLoaderCallback dataLoader;

  Widget _buildItems(BuildContext context, Student student) {
    return StudentCard(student: student);
  }

  void _onAddStudent() {
    const dialog = StudentEditorDialog();
    NavigationService.displayDialog(dialog);
  }



  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    dataLoader(context);

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
                  return ListView.builder(
                    itemCount: state.students.length,
                    itemBuilder: (context, index) =>
                        _buildItems(context, state.students[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: ElevatedButton(
          onPressed: _onAddStudent,
          child: const Icon(AppResources.addIcon),
        ),
      ),
    );
  }
}
