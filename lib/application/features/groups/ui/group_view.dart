import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../logic/group_card_controller.dart';
import '../state/bloc.dart';
import '../state/state.dart';
import 'group_editor.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<GroupsBloc>(context);

    final GroupCardController controller = GroupCardController(group, bloc);

    return SizedBox(
      height: 75,
      child: InkWell(
        onTap: controller.onClick,
        child: Center(
          child: ListTile(
            leading: Text(group.name.value),
            trailing: OptionsButton(
                onClick: () => controller.onMoreActions(localizations)),
          ),
        ),
      ),
    );
  }
}

class GroupsView extends StatelessWidget {
  const GroupsView({super.key, this.displayAppBar = true});

  final bool displayAppBar;

  Widget _buildItems(BuildContext context, Group group) {
    return GroupCard(group: group);
  }

  void _onAddGroup() {
    const dialog = GroupEditorDialog();
    NavigationService.displayDialog(dialog);
  }

  Widget _seperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: displayAppBar
          ? AppBar(
              title: Text(localizations.groupsListLabel),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, state) {
            return ListView.separated(
                separatorBuilder: _seperatorBuilder,
                itemCount: state.groups.length,
                itemBuilder: (context, index) =>
                    _buildItems(context, state.groups[index]));
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: ElevatedButton(
          onPressed: _onAddGroup,
          child: const Icon(AppResources.addIcon),
        ),
      ),
    );
  }
}
