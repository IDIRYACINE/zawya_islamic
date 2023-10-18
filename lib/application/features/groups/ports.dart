import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';

abstract class GroupCardControllerPort {
  void onClick(Group group);
  void onMoreActions(Group group);

  bool get displayOnMoreActions;
  bool get displayFloatingActions;

  void onFloatingClick();

  Future<bool> onSwipe(Group group, BuildContext context);
}

abstract class GroupScheduleEntryControllerPort {
  void onTap(GroupScheduleEntry entry);
  Future<bool> onSwipe(GroupScheduleEntry entry, BuildContext context);
  bool get displayFloatingActions;
  bool get canSwipe;
}

class GroupViewRouteArguments {
  final GroupCardControllerPort? controllerPort;
  final DataLoaderCallback? dataLoader;

  GroupViewRouteArguments({this.dataLoader, this.controllerPort});
}

class GroupScheduleViewRouteArguments {
  final AppLocalizations? localizations;
  final GroupScheduleEntryControllerPort? viewController;
  final GroupsBloc? bloc;

  GroupScheduleViewRouteArguments({
    this.localizations,
    this.viewController,
    this.bloc,
  });
}

class GroupStudentScheduleViewRouteArguments {
  final GroupsBloc? bloc;
  final Group? group;
  final AppLocalizations? localizations;
  final StudentsBloc? studentsBloc;

  GroupStudentScheduleViewRouteArguments(
      {this.bloc, this.group, this.localizations, this.studentsBloc});
}
