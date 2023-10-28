import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/statistiques/logic/controllers.dart';
import 'package:zawya_islamic/application/features/statistiques/logic/helper.dart';
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
    final bloc = BlocProvider.of<SchoolsBloc>(context);

    return BlocBuilder<SchoolsBloc,SchoolState>(
      builder: (context,state) {
        final schoolId = state.selectedSchool?.id;

        if(invalidSchoolStats(schoolId, state.monthlyPresenceStats?.schoolId)){

          loadMonthlyPresenceStats(bloc,schoolId);
        }

        final totalPresence = state.monthlyPresenceStats?.totalPresenceCount ?? 0;
        final totalAbsence = state.monthlyPresenceStats?.totalPresenceCount ?? 0;
        final totalDisciplined = state.monthlyPresenceStats?.totalDisciplinedCount ?? 0;
        final totalChaotic = state.monthlyPresenceStats?.totalChaoticCount ?? 0;

        return SizedBox(
          width:  double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppMeasures.paddingsSmall),
              child: Column(
                mainAxisSize : MainAxisSize.min,
                children: [
                  Text("${localizations.totalPresence}: $totalPresence"),
                  Text("${localizations.totalAbsence}: $totalAbsence"),
                  Text("${localizations.totalDisciplined}: $totalDisciplined"),
                  Text("${localizations.totalChaotic}: $totalChaotic"),
                  
                ],
              )
            ),
          ),
        );
      }
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
                controllerPort: StatistiquesGroupController(studentsBloc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
