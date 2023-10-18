import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/group_schedule/logic/group_schedule_controllers.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/day_translator.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/typography.dart';

import 'widgets.dart';

class GroupScheduleViewV2 extends StatefulWidget {
  const GroupScheduleViewV2(
      {super.key, this.localizations, this.viewController, this.bloc});

  final AppLocalizations? localizations;
  final GroupScheduleEntryControllerPort? viewController;
  final GroupsBloc? bloc;

  @override
  State<GroupScheduleViewV2> createState() => _GroupScheduleViewV2State();
}

class _GroupScheduleViewV2State extends State<GroupScheduleViewV2>
    with SingleTickerProviderStateMixin {
  late AppLocalizations localizations;
  late GroupScheduleEditorController editorController;
  late GroupScheduleEntryControllerPort viewController;
  late GroupsBloc bloc;
  late DayIdTranslator dayIdTranslator;

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
        dayIdTranslator: dayIdTranslator,
      ),
    );
  }

  Widget _buildItem(GroupScheduleEntry entry) {
    return ScheduleEntryWidget(
      entry: entry,
      controller: viewController,
      dayIdTranslator: dayIdTranslator,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      localizations = widget.localizations ?? AppLocalizations.of(context)!;
      bloc = widget.bloc ?? BlocProvider.of<GroupsBloc>(context);
      editorController = GroupScheduleEditorController(bloc);
      viewController = widget.viewController ?? ScheduleEntryController();
      dayIdTranslator = DayIdTranslator(localizations);
    }

    final itemBuilder =
        viewController.canSwipe ? _buildSwipableItem : _buildItem;

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(localizations.groupScheduleLabel),
        ),
        body: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
          final dataSource = state.weekSchedule;

          if (dataSource.isEmpty) {
            return Center(
                child: OnSurfaceText(localizations.emptyScheduleListLabel));
          }

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
