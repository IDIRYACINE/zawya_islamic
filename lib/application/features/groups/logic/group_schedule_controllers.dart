import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/groups/ui/group_schedule_editor.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/formaters.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

class GroupScheduleController {
  GroupScheduleController(this.bloc);

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController startTimeTextController = TextEditingController();

  final TextEditingController endTimeTextController = TextEditingController();

  final GroupsBloc bloc;
  GroupScheduleEntry? scheduleEntry;

  void init(GroupScheduleEntry? entry) {
    if (entry != null) {
      scheduleEntry = entry;
      startTime = entry.startMinuteId.toTimeOfDay();
      endTime = entry.endMinuteId.toTimeOfDay();

      endTimeTextController.text = entry.endMinuteId.toDisplayFormat();
      startTimeTextController.text = entry.startMinuteId.toDisplayFormat();
    }
  }

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void updateStartTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        startTime = time;
        startTimeTextController.text = formatDayTime(time);
      }
    });
  }

  void updateEndTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        endTime = time;
        endTimeTextController.text = formatDayTime(time);
      }
    });
  }

  void onCancel() {
    NavigationService.pop();
  }

  void onConfirm() {
    final isValid = formKey.currentState!.validate();
    final isUpdate = scheduleEntry != null;

    if (isValid) {
      if (isUpdate) {
        _updateEntry();
      } else {
        _createEntry();
      }

      NavigationService.pop();
    }
  }

  void _createEntry() {
    final groupId = bloc.state.selectedGroup!.id;

    final dayIndex = bloc.state.selectedDayIndex;

    final entry = GroupScheduleEntry(
          startMinuteId: DayMinuteId.fromTimeOfDay(startTime!),
          endMinuteId: DayMinuteId.fromTimeOfDay(endTime!),
          groupId: groupId,
          dayId: DayId(dayIndex),
        );

 bloc.add(
      AddDayScheduleEntryEvent(
        dayIndex: dayIndex,
        entry: entry,
      ),
    );

    final options = AddScheduleEntryOptions(entry: entry);
    ServicesProvider.instance().groupService.addGroupScheduleEntry(options);

   
  }

  void _updateEntry() {
    final dayIndex = bloc.state.selectedDayIndex;

    final updatedEntry = scheduleEntry!.copyWith(
        startMinuteId: DayMinuteId.fromTimeOfDay(startTime!),
        endMinuteId: DayMinuteId.fromTimeOfDay(endTime!));

    
    final options = UpdateScheduleEntryOptions(updated: updatedEntry,old:scheduleEntry!);
    ServicesProvider.instance().groupService.updateScheduleEntry(options);    

    bloc.add(
      UpdateDayScheduleEntryEvent(
          dayIndex: dayIndex, old: scheduleEntry!, entry: updatedEntry),
    );
  }
}

class GroupScheduleEntryController {
  final GroupScheduleEntry entry;
  final GroupsBloc bloc;

  GroupScheduleEntryController(this.entry, this.bloc);

  void delete() {
    bloc.add(DeleteDayScheduleEntryEvent(
        dayIndex: bloc.state.selectedDayIndex, entry: entry));
  }

  void update() {
    final dialog = GroupScheduleEditorDialog(groupEntry: entry);

    NavigationService.displayDialog(dialog);
  }
}

Future<void> displaTimePickerDialog() async {
  const dialog = GroupScheduleEditorDialog();

  NavigationService.displayDialog(dialog);
}

abstract class ScheduleEntryController {
  static void onTap(GroupScheduleEntry entry) {
    final dialog = GroupScheduleEditorDialog(
      groupEntry: entry,
    );
    NavigationService.displayDialog(dialog);
  }

  static Future<bool> onSwipe(
      GroupScheduleEntry entry, BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;

    final bloc = BlocProvider.of<GroupsBloc>(context);

    final dialog = ConfirmationDialog(
      content: localizations.deleteLabel,
      onConfirm: () {
        bloc.add(
          DeleteDayScheduleEntryEvent(
              dayIndex: bloc.state.selectedDayIndex, entry: entry),
        );


    final options = DeleteScheduleEntryOptions(entry: entry);
    ServicesProvider.instance().groupService.deleteGroupScheduleEntry(options);


        NavigationService.pop(true);
      },
      title: localizations.confirmLabel,
    );
    final dismiss = await NavigationService.displayDialog<bool>(dialog);

    return dismiss ?? false;
  }
}
