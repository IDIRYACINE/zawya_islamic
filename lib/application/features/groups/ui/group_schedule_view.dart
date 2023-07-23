import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/groups/logic/group_schedule_controllers.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';

class GroupScheduleView extends StatefulWidget {
  const GroupScheduleView({super.key});

  @override
  State<GroupScheduleView> createState() => _GroupScheduleViewState();
}

class _GroupScheduleViewState extends State<GroupScheduleView>
    with SingleTickerProviderStateMixin {
  late AppLocalizations localizations;
  late GroupScheduleController controller;
  late GroupsBloc bloc;

  late TabController tabController;

  bool isInit = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  void updateDayIndex(int index) {
    bloc.add(SelectDayIndexEvent(dayIndex: index));
    tabController.index = index;
  }

  Widget _buildItem(GroupScheduleEntry entry) {
    final key = Key(entry.toString());
    return Dismissible(
        key: key,
        confirmDismiss: (direction) =>
            ScheduleEntryController.onSwipe(entry, context),
        child: ScheduleEntryWidget(
          entry: entry,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      localizations = AppLocalizations.of(context)!;
      bloc = BlocProvider.of<GroupsBloc>(context);
      controller = GroupScheduleController(bloc);
    }

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
          final dataSource = state.daySchedule;

          return ListView.builder(
            itemCount: dataSource.length,
            itemBuilder: (context, index) => _buildItem(dataSource[index]),
          );
        }),
        floatingActionButton: const FloatingActionButton(
          onPressed: displaTimePickerDialog,
          child: Icon(AppResources.addIcon),
        ),
      ),
    );
  }
}

class ScheduleEntryWidget extends StatelessWidget {
  final GroupScheduleEntry entry;

  const ScheduleEntryWidget({super.key, required this.entry});

  String _formatedTime() {
    return "${entry.startMinuteId.toDisplayFormat()} - ${entry.endMinuteId.toDisplayFormat()}";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ScheduleEntryController.onTap(entry),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppMeasures.paddings),
          child: Text(
            _formatedTime(),
          ),
        ),
      ),
    );
  }
}
