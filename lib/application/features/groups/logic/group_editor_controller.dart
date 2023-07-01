import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';

import '../state/bloc.dart';
import '../state/events.dart';

//TODO : make call to infrastructure

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


  void _updateGroup(Group group){
    final updatedGroup = group.copyWith(
      name: Name(groupName)
    );

    final event = UpdateGroupEvent(group: updatedGroup);
    final bloc = BlocProvider.of<GroupsBloc>(key.currentContext!);
    
    bloc.add(event);
  }

  void _createGroup(){
    final group = Group(name: Name(groupName), id: GroupId(const Uuid().v4())) ;
    final bloc = BlocProvider.of<GroupsBloc>(key.currentContext!);

    final event = CreateGroupEvent(group: group);

    bloc.add(event);

  }
}
