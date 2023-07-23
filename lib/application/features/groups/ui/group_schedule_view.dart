import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/groups/logic/group_schedule_controllers.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/resources.dart';

class GroupScheduleView extends StatefulWidget {
  GroupScheduleView({super.key});

  final GroupScheduleController controller = GroupScheduleController();

  @override
  State<GroupScheduleView> createState() => _GroupScheduleViewState();
}

class _GroupScheduleViewState extends State<GroupScheduleView> {
  int selectedDayIndex = 0;

  Widget _itemBuilder(BuildContext context, int index) {
    return const Text("");
  }

  void updateDayIndex(int index) {}

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            onTap: updateDayIndex,
            tabs: [
              Tab(text: localizations.saturday),
              Tab(text: localizations.sunday),
              Tab(text: localizations.monday),
              Tab(text: localizations.tuesday),
              Tab(text: localizations.wednesday),
              Tab(text: localizations.thursday),
              Tab(text: localizations.friday),
            ],
          ),
        ),
        body: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
          return ListView.builder(itemBuilder: _itemBuilder);
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => widget.controller
              .displaTimePickerDialog(context, TimeOfDay.now()),
          child: const Icon(AppResources.addIcon),
        ),
      ),
    );
  }
}
