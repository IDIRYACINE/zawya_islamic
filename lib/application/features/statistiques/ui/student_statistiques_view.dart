import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/measures.dart';

import 'widgets.dart';

class StudentStatistiquesCard extends StatelessWidget {
  const StudentStatistiquesCard(
      {super.key, required this.evaluationAndPresence});

  final StudentEvaluationAndPresence evaluationAndPresence;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddings),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Text(evaluationAndPresence.student.name.value)),
              EvaluationRowWidget(
                  evaluation: evaluationAndPresence.evaluation.evaluation),
            Expanded(child: PresenseMeterWidget(presence: evaluationAndPresence.presence,))
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
