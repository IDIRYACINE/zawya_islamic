import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/statistiques/logic/controllers.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';

class OverallStatistiquesCard extends StatelessWidget {
  const OverallStatistiquesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddingsSmall),
        child: ListTile(
          leading: Text(localizations.about),
        ),
      ),
    );
  }
}

class StatistiquesView extends StatelessWidget {
  const StatistiquesView(
      {super.key, this.displayAppBar = true, });

  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
     final studentsBloc =
        BlocProvider.of<StudentsBloc>(context); 


    return Scaffold(
      appBar: displayAppBar
          ? AppBar(
              title: Text(localizations.statistiques),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: Column(
          children: [
            const Flexible(
              child: OverallStatistiquesCard(),
            ),
            Expanded(
              child: GroupsView(
                paddings: 0,
                displayAppBar: false,
                displayFloatingAction: false,
                controllerPort: StatistiquesGroupController(studentsBloc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
