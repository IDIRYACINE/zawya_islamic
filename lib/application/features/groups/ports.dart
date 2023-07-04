import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';

abstract class GroupCardControllerPort {
  void onClick(Group group);
  void onMoreActions(Group group, AppLocalizations localizations);

  bool get displayOnMoreActions;
}
