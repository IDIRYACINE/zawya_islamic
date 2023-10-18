import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/group_schedule/logic/schedule_students_controller.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/loaded.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/images.dart';

class GroupScheduleStudentsView extends StatelessWidget {
  const GroupScheduleStudentsView({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    final controller = GroupStudentsScheduleController(context, group);
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ScheduleCard(localization.groupScheduleLabel, controller),
          _StudentsCard(localization.studentListLabel, controller)
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard(this.title, this.controller);
  final GroupStudentsScheduleController controller;

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMeasures.cardHeight,
      child: InkWell(
        onTap: controller.navigateToSchedule,
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AccentIcon(
                  iconDataAsset: LoadedAppResources.groupsWhite,
                ),
                Text(title),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentsCard extends StatelessWidget {
  const _StudentsCard(this.title, this.controller);
  final String title;
  final GroupStudentsScheduleController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMeasures.cardHeight,
      child: InkWell(
        onTap: controller.navigateToStudents,
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AccentIcon(
                  iconDataAsset: LoadedAppResources.groupsWhite,
                ),
                Text(title),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
