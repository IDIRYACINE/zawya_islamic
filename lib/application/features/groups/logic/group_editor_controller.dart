import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

import '../state/bloc.dart';
import '../state/events.dart';

class GroupEditorController {
  static final key = GlobalKey<FormState>();

  GroupEditorController([String? groupName]) {
    this.groupName = groupName ?? "";
  }

  late String groupName;

  void updateName(String value) {
    groupName = value;
  }

  void createOrUpdate(Group? group) {
    final isValid = key.currentState!.validate();

    if (isValid) {
      if (group != null) {
        _updateGroup(group);
        return;
      }

      _createGroup();
    }
  }

  void _updateGroup(Group group) {
    final updatedGroup = group.copyWith(name: Name(groupName));
    final groupBloc = BlocProvider.of<GroupsBloc>(key.currentContext!);
    final schoolId = BlocProvider.of<SchoolsBloc>(key.currentContext!)
        .state
        .selectedSchool!
        .id;

    final options = UpdateGroupOptions(group: group, schoolId: schoolId);

    ServicesProvider.instance()
        .groupService
        .updateGroup(options)
        .then((value) => groupBloc.add(UpdateGroupEvent(group: updatedGroup)));
  }

  void _createGroup() {
    final schoolId = BlocProvider.of<SchoolsBloc>(key.currentContext!)
        .state
        .selectedSchool!
        .id;

    final group = Group(name: Name(groupName), id: GroupId(const Uuid().v4()));

    final options = RegisterGroupOptions(group: group, schoolId: schoolId);

    final groupBloc = BlocProvider.of<GroupsBloc>(key.currentContext!);

    ServicesProvider.instance()
        .groupService
        .registerGroup(options)
        .then((value) => groupBloc.add(CreateGroupEvent(group: group)));
  }
}
