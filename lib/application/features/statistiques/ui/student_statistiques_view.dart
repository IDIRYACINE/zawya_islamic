import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/group_statistiques.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';

import 'widgets.dart';

class StudentStatistiquesCard extends StatelessWidget {
  const StudentStatistiquesCard(
      {super.key, required this.evaluationAndPresence});

  final StudentEvaluationAndPresence evaluationAndPresence;

  @override
  Widget build(BuildContext context) {
    final displayTitle =
        "${evaluationAndPresence.student.name.value} - ${evaluationAndPresence.student.birthDate.toPostgressDate()}";
    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddings),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Text(displayTitle)),
              EvaluationRowWidget(
                  evaluation: evaluationAndPresence.evaluation.evaluation),
              Expanded(
                  child: PresenseMeterWidget(
                presence: evaluationAndPresence.presence,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class GroupStudentStatistiques extends StatelessWidget {
  const GroupStudentStatistiques({super.key});

  Widget _itemBuilder(StudentEvaluationAndPresence evaluationAndPresence) {
    return StudentStatistiquesCard(
      evaluationAndPresence: evaluationAndPresence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

class GroupStatistiquesCard extends StatelessWidget {
  const GroupStatistiquesCard(
      {super.key,
      required this.groupStatistiques,
      required this.localizations});

  final GroupStatistiques groupStatistiques;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final disciplined = "${localizations.totalDisciplined} : "
        "${groupStatistiques.discipline.value}";
    final chaotic =
        "${localizations.totalChaotic} : ${groupStatistiques.chaotic.value}";
    final presence =
        "${localizations.totalPresence} : ${groupStatistiques.presence.value}";
    final absence =
        "${localizations.totalAbsence} : ${groupStatistiques.absence.value}";

    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddings),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Text(groupStatistiques.group.name.value)),
              Row(
                children: [
                  Expanded(child: Text(presence)),
                  Expanded(child: Text(absence)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text(disciplined)),
                  Expanded(child: Text(chaotic)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
