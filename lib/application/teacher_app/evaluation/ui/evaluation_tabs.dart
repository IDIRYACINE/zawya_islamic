import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/state.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';

import '../logic/evaluation_card_controller.dart';

class StudentEvaluationTab extends StatefulWidget {
  const StudentEvaluationTab({super.key});

  @override
  State<StatefulWidget> createState() => _StudentEvaluationTabState();
}

class _StudentEvaluationTabState extends State<StudentEvaluationTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<StudentsBloc, StudentsState>(builder: (context, state) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(text: localizations.unEvaluatedLabel),
                Tab(text: localizations.evaluatedLabel)
              ],
            ),
          ),
          body: TabBarView(children: [
            EvaluationTabView(
              students: state.unEvaluated,
              isEvaluated: false,
            ),
            EvaluationTabView(
              students: state.evaluations,
            ),
          ]),
        ),
      );
    });
  }
}

class EvaluationCard extends StatelessWidget {
  const EvaluationCard(
      {super.key,
      required this.evaluation,
      required this.isEvaluated,
      required this.controller});

  final StudentEvaluation evaluation;
  final bool isEvaluated;
  final EvaluationCardController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => controller.onTap(evaluation, !isEvaluated),
        child: ListTile(
          leading: Text(evaluation.student.name.value),
          trailing: Switch(
              value: isEvaluated,
              onChanged: (value) => controller.onTap(evaluation, value)),
        ),
      ),
    );
  }
}

class EvaluationTabView extends StatelessWidget {
  const EvaluationTabView(
      {super.key, required this.students, this.isEvaluated = true});

  final List<StudentEvaluation> students;
  final bool isEvaluated;

  Widget _buildItem(BuildContext context, StudentEvaluation student,
      EvaluationCardController evaluationCardController) {
    return EvaluationCard(
      evaluation: student,
      isEvaluated: isEvaluated,
      controller: evaluationCardController,
    );
  }

  Widget _speperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StudentsBloc>(context);
    final evaluationCardController = EvaluationCardController(bloc);

    return ListView.separated(
        itemBuilder: (context, index) =>
            _buildItem(context, students[index], evaluationCardController),
        separatorBuilder: _speperatorBuilder,
        itemCount: students.length);
  }
}
