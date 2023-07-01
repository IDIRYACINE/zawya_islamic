import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/students/state/bloc.dart';
import 'package:zawya_islamic/application/admin_app/students/ui/student_editor.dart';
import 'package:zawya_islamic/application/navigation/feature.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';

import '../state/state.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  void _onClick(){
    final dialog = StudentEditorDialog(student: student,);
    NavigationService.displayDialog(dialog);
  }



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onClick,
      child: Card(
        child: Text(student.name.value),
      ),
    );
  }
}

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.studentListLabel),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<StudentsBloc, StudentsState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.students.length,
                    itemBuilder: (context, index) =>
                        _buildItems(context, state.students[index]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppMeasures.paddings),
            child: ElevatedButton(
              onPressed: _onAddStudent,
              child: const Icon(AppResources.addIcon),
            ),
          ),
        ],
      ),
    );
  }
}
