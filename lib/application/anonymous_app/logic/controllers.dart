

import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/admin_app/layout/helpers.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/schedules.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

class AnonymousSchoolCardController implements SchoolCardControllerPort{
  final SchoolsBloc schoolBloc;
  final GroupsBloc groupsBloc;

  const AnonymousSchoolCardController(this.schoolBloc, this.groupsBloc);

  @override
  bool get displayFloatingAction => false;

  @override
  bool get displayOnMoreActions => false;


  @override
  void onClick(School school) {

    final arguments = GroupViewRouteArguments(
      dataLoader: loadGroups,
      controllerPort: AnonymousGroupCardController(groupsBloc),
    );

    schoolBloc.add(SelectSchoolEvent(school: school));
    NavigationService.pushNamed(Routes.groupsRoute,arguments:arguments);
  }

  @override
  void onFloatingClick() {
    throw ("Not authorised");
  }

  @override
  void onMoreActions(School school) {
    throw ("Not authorised");
  }
  
  @override
  Future<bool> onSwipe(School school, context) {
    throw UnimplementedError();
  }
  

}

class AnonymousGroupCardController implements GroupCardControllerPort{
  final GroupsBloc groupsBloc ;

  AnonymousGroupCardController(this.groupsBloc);

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {
    final options = LoadGroupScheduleOptions(groupId: group.id);
    ServicesProvider.instance()
        .groupService
        .loadGroupSchedule(options)
        .then((res) {
      groupsBloc.add(
        SetWeekDaySchedulesEvent(schedules: res.data),
      );
    });

    groupsBloc.add(SelectGroupEvent(group: group));

    final arguments = GroupScheduleViewRouteArguments(
      viewController: AnonymousScheduleController()
    );

    NavigationService.pushNamed(Routes.groupScheduleRoute,arguments:arguments);
  }

  @override
  void onFloatingClick() {
    throw ("Not authorised");
  }

  @override
  void onMoreActions(Group group) {
    throw ("Not authorised");
  }
  
  @override
  bool get displayFloatingActions => false;
  
  @override
  Future<bool> onSwipe(Group group, BuildContext context) {
    throw UnimplementedError();
  }

}

class AnonymousScheduleController implements GroupScheduleEntryControllerPort{

  @override
  bool get displayFloatingActions => false;

  @override
  Future<bool> onSwipe(GroupScheduleEntry entry, BuildContext context) async{
   return false;
  }

  @override
  void onTap(GroupScheduleEntry entry) {
   
  }
  
  @override
  bool get canSwipe => false;

}