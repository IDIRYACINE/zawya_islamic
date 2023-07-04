import 'package:zawya_islamic/application/features/groups/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../ports.dart';
import '../state/bloc.dart';
import '../ui/group_editor.dart';

class GroupCardController implements GroupCardControllerPort {
  const GroupCardController(this.bloc);

  final GroupsBloc bloc;

  @override
  void onClick(Group group) {}

  @override
  void onMoreActions(Group group, AppLocalizations localizations) {
    final options = [
      OptionsButtonData(
          callback: () => _onDelete(
              localizations.permanentActionWarning, localizations.deleteLabel,group),
          title: localizations.deleteLabel),
      OptionsButtonData(callback: () => _onEdit(group), title: localizations.editLabel)
    ];

    final dialog = OptionsAlertDialog(options: options);
    NavigationService.displayDialog(dialog);
  }

  void _onDelete(String content, String title,Group group) {
    final dialog = ConfirmationDialog(
        onConfirm: () {
          final event = DeleteGroupEvent(group: group);
          bloc.add(event);
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
}
