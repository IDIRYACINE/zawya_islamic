import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/relations.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

class TeacherAdminGroupController implements GroupCardControllerPort {
  final GroupsBloc groupsBloc;
  final UserId userId;

  TeacherAdminGroupController(this.groupsBloc, this.userId);

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {
    groupsBloc.add(
      DeleteGroupEvent(group: group, isPrimary: false),
    );

    final options = DeleteUserGroupOptions(
      userGroup: UserGroup(userId: userId, groupId: group.id),
    );

    ServicesProvider.instance().groupService.deleteUserGroup(options);
  }

  @override
  void onMoreActions(Group group, AppLocalizations localizations) {}

  @override
  void onFloatingClick() {
    const dialog = GroupSelectorDialog();

    NavigationService.displayDialog<Group>(dialog).then((selectedGroup) {
      if (selectedGroup != null) {
        groupsBloc
            .add(CreateGroupEvent(group: selectedGroup, isPrimary: false));

        final options = RegisterUserGroupOptions(
            userGroup: UserGroup(userId: userId, groupId: selectedGroup.id));

        ServicesProvider.instance().groupService.registerUserGroup(options);
      }
    });
  }

  @override
  bool get displayFloatingActions => true;
}

void loadTeacherGroups(BuildContext context, TeacherId teacherId) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);

  final options = LoadTeacherGroupsOptions(teacherId: teacherId);

  ServicesProvider.instance().groupService.getTeacherGroups(options).then(
      (res) =>
          groupsBloc.add(LoadGroupsEvent(groups: res.data, isPrimary: false)));
}
