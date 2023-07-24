import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/groups/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../ports.dart';
import '../state/bloc.dart';
import '../ui/group_editor.dart';

class GroupCardController implements GroupCardControllerPort {
  const GroupCardController(this.groupsBloc, this.schoolBloc);

  final GroupsBloc groupsBloc;
  final SchoolsBloc schoolBloc;

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

    NavigationService.pushNamed(Routes.groupScheduleRoute);
  }

  @override
  void onMoreActions(Group group, AppLocalizations localizations) {
    final options = [
      OptionsButtonData(
          callback: () => _onDelete(localizations.permanentActionWarning,
              localizations.deleteLabel, group),
          title: localizations.deleteLabel),
      OptionsButtonData(
          callback: () => _onEdit(group), title: localizations.editLabel)
    ];

    final dialog = OptionsAlertDialog(options: options);
    NavigationService.displayDialog(dialog);
  }

  void _onDelete(String content, String title, Group group) {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final options = DeleteGroupOptions(
              groupId: group.id, schoolId: schoolBloc.state.selectedSchool!.id);

          ServicesProvider.instance().groupService.deleteGroup(options).then(
                (value) => groupsBloc.add(
                  DeleteGroupEvent(group: group),
                ),
              );

          NavigationService.pop();
        },
        title: title,
        content: content);

    NavigationService.replaceDialog(dialog);
  }

  void _onEdit(Group group) {
    final dialog = GroupEditorDialog(
      group: group,
    );

    NavigationService.replaceDialog(dialog);
  }

  @override
  bool get displayOnMoreActions => true;

  @override
  void onFloatingClick() {
    const dialog = GroupEditorDialog();
    NavigationService.displayDialog(dialog);
  }
  
  @override
  bool get displayFloatingActions => true;
}
