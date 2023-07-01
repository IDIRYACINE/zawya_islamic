import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/formaters.dart';

import '../utility/validators.dart';

typedef OnChanged = void Function(String value);

class BirthDateField extends StatelessWidget {
  const BirthDateField({super.key, this.onChanged});

  final OnChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textController = TextEditingController();

    Future<void> selectDate() async {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime(2012),
        firstDate: DateTime(2012),
        lastDate: DateTime(2018),
        onDatePickerModeChange: (mode) {},
        initialDatePickerMode: DatePickerMode.year,
      );

      if (date != null) {
        textController.text = formatDateTimeToDisplay(date);
      }
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: localizations.birthDateLabel,
      ),
      controller: textController,
      readOnly: true,
      onTap: selectDate,
      validator: (value) => dateValidator(value, localizations),
    );
  }
}
