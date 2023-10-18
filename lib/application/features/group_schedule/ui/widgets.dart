import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/types.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/utility/day_translator.dart';

class ScheduleEntryWidget extends StatelessWidget {
  final GroupScheduleEntry entry;
  final GroupScheduleEntryControllerPort controller;
  final DayIdTranslator dayIdTranslator;

  const ScheduleEntryWidget(
      {super.key,
      required this.entry,
      required this.controller,
      required this.dayIdTranslator});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(dayIdTranslator.getDayFromId(entry.dayId)),
                Text(
                  _formatedTime(),
                ),
              ],
            )),
      ),
    );
  }
}

class DaySelector extends StatefulWidget {
  const DaySelector(
      {super.key, required this.onSelected, this.validator, this.dayIdInitial});

  final DayId? dayIdInitial;
  final OnDaySelectedCallback onSelected;
  final FormFieldValidator? validator;

  @override
  State<StatefulWidget> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  late List<Day> days;
  bool isInit = false;

  List<DropdownMenuItem<Day>> buildItems() {
    final List<DropdownMenuItem<Day>> items = [];

    for (Day day in days) {
      items.add(DropdownMenuItem(value: day, child: Text(day.name)));
    }

    return items;
  }

  Day? _getInitialDay() {
    Day? target;

    try {
      target = days
          .where((element) => element.id.value == widget.dayIdInitial!.value)
          .first;
    } catch (e) {
      target = null;
    }

    return target;
  }

  List<Day> generateDays(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final dayTransaltor = DayIdTranslator(localizations);

    List<Day> tDays = [];
    for (int i = 0; i < 7; i++) {
      final dayId = DayId(i);
      tDays.add(Day(id: dayId, name: dayTransaltor.getDayFromId(dayId)));
    }

    return tDays;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle =
        theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary);

    days = generateDays(context);

    final initialValue = widget.dayIdInitial == null ? null : _getInitialDay();

    return DropdownButtonFormField<Day>(
        validator: widget.validator,
        items: buildItems(),
        value: initialValue,
        style: textStyle,
        onChanged: widget.onSelected);
  }
}
