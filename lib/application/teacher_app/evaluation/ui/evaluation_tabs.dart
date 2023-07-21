import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/state.dart';
import 'package:zawya_islamic/core/entities/presence.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';

import '../logic/evaluation_card_controller.dart';

class EvaluationCard extends StatelessWidget {
  const EvaluationCard(
      {super.key,
      required this.evaluation,
      required this.isEvaluated,
      required this.controller});

  final StudentEvaluationAndPresence evaluation;
  final bool isEvaluated;
  final EvaluationCardController controller;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      child: InkWell(
        onTap: () => controller.onTap(evaluation, !isEvaluated),
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddings),
          child: Column(
            children: [
              Text(evaluation.student.name.value),
              const SizedBox(height: AppMeasures.space,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      "${localizations.surat} : ${evaluation.evaluation.evaluation.suratName}"),
                  Text(
                      "${localizations.ayat} : ${evaluation.evaluation.evaluation.ayatNumber}"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EvaluationTabView extends StatelessWidget {
  const EvaluationTabView(
      {super.key, required this.students, this.isEvaluated = true});

  final List<StudentEvaluationAndPresence> students;
  final bool isEvaluated;

  Widget _buildItem(BuildContext context, StudentEvaluationAndPresence student,
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

    return Padding(
      padding: const EdgeInsets.all(AppMeasures.paddingsLarge),
      child: ListView.separated(
          itemBuilder: (context, index) =>
              _buildItem(context, students[index], evaluationCardController),
          separatorBuilder: _speperatorBuilder,
          itemCount: students.length),
    );
  }
}

class MonthyEvaluationTab extends StatelessWidget {
  const MonthyEvaluationTab({super.key});

  Widget _buildItem(BuildContext context, StudentEvaluationAndPresence student,
      EvaluationCardController evaluationCardController) {
    return EvaluationCard(
      evaluation: student,
      isEvaluated: true,
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

    return BlocBuilder<StudentsBloc, StudentsState>(
      builder: (context, state) {
      final studentsEvaluations = state.presenceAndEvaluation;

      return ListView.separated(
          itemBuilder: (context, index) => _buildItem(
              context, studentsEvaluations[index], evaluationCardController),
          separatorBuilder: _speperatorBuilder,
          itemCount: studentsEvaluations.length);
    });
  }
}
