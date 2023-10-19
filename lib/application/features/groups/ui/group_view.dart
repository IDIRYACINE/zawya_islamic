import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/loaded.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';
import 'package:zawya_islamic/widgets/images.dart';
import 'package:zawya_islamic/widgets/typography.dart';

import '../logic/group_card_controller.dart';
import '../ports.dart';
import '../state/bloc.dart';
import '../state/state.dart';

class GroupCard extends StatelessWidget {
  final Group group;
  final GroupCardControllerPort controllerPort;

  const GroupCard(
      {super.key, required this.group, required this.controllerPort});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMeasures.cardHeight,
      child: InkWell(
        onTap: () => controllerPort.onClick(group),
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AccentIcon(
                  iconDataAsset: LoadedAppResources.groupsWhite,
                ),
                Text(group.name.value),
                controllerPort.displayOnMoreActions
                    ? OptionsButton(
                        onClick: () => controllerPort.onMoreActions(group),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupsView extends StatelessWidget {
  const GroupsView({
    super.key,
    this.onReturn,
    this.displayAppBar = true,
    this.controllerPort,
    this.dataLoader,
    this.usePrimarySource = true,
    this.paddings = AppMeasures.paddings,
  });

  final bool displayAppBar;
  final VoidCallback? onReturn;
  final GroupCardControllerPort? controllerPort;
  final DataLoaderCallback? dataLoader;
  final bool usePrimarySource;
  final double paddings;

  Widget _buildSwipableItem(
      BuildContext context, Group group, GroupCardControllerPort controller) {
    final key = Key(group.id.value);

    return Dismissible(
      key: key,
      confirmDismiss: (direction) => controller.onSwipe(group, context),
      child: GroupCard(
        group: group,
        controllerPort: controller,
      ),
    );
  }

  Widget _buildItems(
      BuildContext context, Group group, GroupCardControllerPort controller) {
    return GroupCard(
      group: group,
      controllerPort: controller,
    );
  }

  List<Group> _targetGroups(GroupsState state) {
    return usePrimarySource ? state.groups : state.secondaryGroups;
  }

  Widget _seperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 20,
    );
  }

  PreferredSizeWidget? _buildAppBar(AppLocalizations localizations) {
    return displayAppBar
        ? AppBar(
            leading: onReturn != null
                ? InkWell(
                    onTap: () {
                      onReturn!.call();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )
                : null,
            title: Text(localizations.groupsListLabel),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<GroupsBloc>(context);
    final schoolBloc = BlocProvider.of<SchoolsBloc>(context);

    final controller = controllerPort ?? GroupCardController(bloc, schoolBloc);
    dataLoader?.call(context);
    final itemBuilder =
        controller.displayOnMoreActions ? _buildSwipableItem : _buildItems;

    return Scaffold(
      appBar: _buildAppBar(localizations),
      body: Padding(
        padding: EdgeInsets.all(paddings),
        child: BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, state) {
            final groups = _targetGroups(state);

            if (groups.isEmpty)
              return Center(
                  child: OnSurfaceText(localizations.emptyGroupsListLabel));

            return ListView.separated(
              separatorBuilder: _seperatorBuilder,
              itemCount: groups.length,
              itemBuilder: (context, index) =>
                  itemBuilder(context, groups[index], controller),
            );
          },
        ),
      ),
      floatingActionButton: controller.displayFloatingActions
          ? AddButton(
              onPressed: controller.onFloatingClick,
            )
          : null,
    );
  }
}
