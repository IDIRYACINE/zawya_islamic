import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/groups/logic/group_schedule_controllers.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

class GroupScheduleView extends StatefulWidget {
  const GroupScheduleView(
      {super.key, this.localizations, this.viewController, this.bloc});

  final AppLocalizations? localizations;
  final GroupScheduleEntryControllerPort? viewController;
  final GroupsBloc? bloc;

  @override
  State<GroupScheduleView> createState() => _GroupScheduleViewState();
}

class _GroupScheduleViewState extends State<GroupScheduleView>
    with SingleTickerProviderStateMixin {
  late AppLocalizations localizations;
  late GroupScheduleEditorController editorController;
  late GroupScheduleEntryControllerPort viewController;
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

  Widget _buildSwipableItem(GroupScheduleEntry entry) {
    final key = Key(entry.toString());

    return Dismissible(
      key: key,
      confirmDismiss: (direction) => viewController.onSwipe(entry, context),
      child: ScheduleEntryWidget(
        entry: entry,
        controller: viewController,
      ),
    );
  }

  Widget _buildItem(GroupScheduleEntry entry) {
    return ScheduleEntryWidget(
      entry: entry,
      controller: viewController,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      localizations = widget.localizations ?? AppLocalizations.of(context)!;
      bloc = widget.bloc ?? BlocProvider.of<GroupsBloc>(context);
      editorController = GroupScheduleEditorController(bloc);
      viewController = widget.viewController ?? ScheduleEntryController();
    }

    final itemBuilder =
        viewController.canSwipe ? _buildSwipableItem : _buildItem;

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            onTap: updateDayIndex,
            isScrollable: true,
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
            itemBuilder: (context, index) => itemBuilder(dataSource[index]),
          );
        }),
        floatingActionButton: viewController.displayFloatingActions
            ? const AddButton(
                onPressed: displaTimePickerDialog,
              )
            : null,
      ),
    );
  }
}

class ScheduleEntryWidget extends StatelessWidget {
  final GroupScheduleEntry entry;
  final GroupScheduleEntryControllerPort controller;

  const ScheduleEntryWidget(
      {super.key, required this.entry, required this.controller});

  String _formatedTime() {
    return "${entry.startMinuteId.toDisplayFormat()} - ${entry.endMinuteId.toDisplayFormat()}";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onTap(entry),
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
