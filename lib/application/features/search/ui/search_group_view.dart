import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/search/logic/search_group_controller.dart';
import 'package:zawya_islamic/application/features/statistiques/ui/student_statistiques_view.dart';
import 'package:zawya_islamic/core/entities/group_statistiques.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';

class SearchGroupView extends StatelessWidget {
  const SearchGroupView({super.key});

  Widget _itemBuilder(
      GroupStatistiques groupStats, AppLocalizations localizations) {
    return GroupStatistiquesCard(
      groupStatistiques: groupStats,
      localizations: localizations,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const GroupSearchAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
          return ListView.builder(
            itemCount: state.search.length,
            itemBuilder: (context, index) =>
                _itemBuilder(state.search[index], appLocalizations),
          );
        }),
      ),
    );
  }
}

class GroupSearchAppBar extends StatelessWidget {
  const GroupSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = GroupSearchController(context);
    final textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);

    return TextFormField(
      decoration: InputDecoration(
        hintText: localizations.searchGroupHint,
        suffix: MaterialButton(
          onPressed: controller.searchGroup,
          child: Text(
            localizations.searchLabel,
            style: textStyle,
          ),
        ),
      ),
      onChanged: controller.updateGroupName,
    );
  }
}
