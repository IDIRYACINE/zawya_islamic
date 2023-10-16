import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/relations.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

class StudentAdminGroupController implements GroupCardControllerPort {
  final GroupsBloc groupsBloc;
  final UserId userId;
  final AppLocalizations localizations;

  StudentAdminGroupController(this.groupsBloc, this.userId, this.localizations);

  @override
  bool get displayOnMoreActions => false;

  @override
  void onClick(Group group) {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          groupsBloc.add(
            DeleteGroupEvent(group: group, isPrimary: false),
          );

          final options = DeleteUserGroupOptions(
            userGroup: UserGroup(userId: userId, groupId: group.id),
          );

          ServicesProvider.instance().groupService.deleteUserGroup(options);

          NavigationService.pop();
        },
        title: localizations.deleteLabel,
        content: localizations.permanentActionWarning);

        NavigationService.displayDialog(dialog);
  }

  @override
  void onMoreActions(Group group) {}

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

  @override
  Future<bool> onSwipe(Group group, BuildContext context) {
    throw UnimplementedError();
  }
}
