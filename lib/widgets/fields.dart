import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/formaters.dart';


typedef OnChanged = void Function(DateTime value);

class BirthDateField extends StatelessWidget {
  const BirthDateField({super.key,required this.onChanged, required this.initialValue});

  final OnChanged onChanged;
  final DateTime initialValue;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textController = TextEditingController();
    textController.text = formatDateTimeToDisplay(initialValue);

    Future<void> selectDate() async {
      final date = await showDatePicker(
        context: context,
        initialDate: initialValue,
        firstDate: DateTime(1980),
        lastDate: DateTime(2050),
        onDatePickerModeChange: (mode) {},
        initialDatePickerMode: DatePickerMode.year,
      );

      if (date != null) {
        textController.text = formatDateTimeToDisplay(date);
        onChanged(date);
      }
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: localizations.birthDateLabel,
      ),
      controller: textController,
      readOnly: true,
      onTap: selectDate,
    );
  }
}
