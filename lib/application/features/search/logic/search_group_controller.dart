import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

class GroupSearchController {
  late GroupsBloc _groupsBloc;
  late SchoolsBloc _schoolsBloc;
  late AppLocalizations _localizations;
  String? _groupName;

  GroupSearchController(BuildContext context) {
    _groupsBloc = BlocProvider.of<GroupsBloc>(context);
    _schoolsBloc = BlocProvider.of<SchoolsBloc>(context);
    _localizations = AppLocalizations.of(context)!;
  }

  void updateGroupName(String? name) {
    _groupName = name;
  }

  void searchGroup() {
    if (_groupName == null || _groupName == '') {
      NavigationService.displayDialog(
          InfoDialog(message: _localizations.emptyFieldError));
    }

    final schoolId = _schoolsBloc.state.selectedSchool!.id;

    final searchOptions =
        SearchGroupOptions(groupName: _groupName!, schoolId: schoolId);
    ServicesProvider.instance()
        .groupService
        .searchGroup(searchOptions)
        .then((res) {
      final event = LoadGroupSearchEvent(groups: res.data);
      _groupsBloc.add(event);
    });
  }
}
