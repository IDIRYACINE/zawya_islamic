import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/search/logic/search_student_controller.dart';
import 'package:zawya_islamic/application/features/statistiques/ui/student_statistiques_view.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';

class SearchStudentView extends StatelessWidget {
  const SearchStudentView({super.key});

  Widget _itemBuilder(StudentEvaluationAndPresence evaluationAndPresence) {
    return StudentStatistiquesCard(
      evaluationAndPresence: evaluationAndPresence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StudentSearchAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child:
            BlocBuilder<StudentsBloc, StudentsState>(builder: (context, state) {
          return ListView.builder(
            itemCount: state.presenceAndEvaluation.length,
            itemBuilder: (context, index) => _itemBuilder(
              state.presenceAndEvaluation[index],
            ),
          );
        }),
      ),
    );
  }
}

class StudentSearchAppBar extends StatelessWidget {
  const StudentSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = StudentSearchController(context);
    final textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);

    return TextFormField(
      decoration: InputDecoration(
        hintText: localizations.searchStudentHint,
        suffix: MaterialButton(
          onPressed: controller.searchStudent,
          child: Text(
            localizations.searchLabel,
            style: textStyle,
          ),
        ),
      ),
      onChanged: controller.updateStudentName,
    );
  }
}
