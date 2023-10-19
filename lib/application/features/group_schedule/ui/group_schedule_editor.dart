import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/groups/export.dart';
import 'package:zawya_islamic/application/features/group_schedule/logic/group_schedule_controllers.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

import 'widgets.dart';

class GroupScheduleEditor extends StatelessWidget {
  const GroupScheduleEditor({super.key, required this.controller});

  final GroupScheduleEditorController controller;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          DaySelector(
            dayIdInitial: DayId(0),
            onSelected: controller.onDaySelected,
            validator: (value) => emptyValidator(value.name, localizations),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: localizations.roomLabel),
            controller: controller.roomTextController,
            readOnly: true,
            validator: (value) => emptyValidator(value, localizations),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: localizations.start,
            ),
            readOnly: true,
            controller: controller.startTimeTextController,
            onTap: () => controller.updateStartTime(context),
            validator: (value) => emptyValidator(value, localizations),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: localizations.end),
            controller: controller.endTimeTextController,
            readOnly: true,
            onTap: () => controller.updateEndTime(context),
            validator: (value) => emptyValidator(value, localizations),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: controller.onCancel,
                child: Text(localizations.cancelLabel),
              ),
              ButtonPrimary(
                onPressed: controller.onConfirm,
                text: localizations.confirmLabel,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class GroupScheduleEditorDialog extends StatelessWidget {
  const GroupScheduleEditorDialog({super.key, this.groupEntry});
  final GroupScheduleEntry? groupEntry;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<GroupsBloc>(context);
    final controller = GroupScheduleEditorController(bloc);
    controller.init(groupEntry);

    return AlertDialog(
      content: SizedBox(
        height: size.height * 0.5,
        width: size.width * 0.5,
        child: GroupScheduleEditor(
          controller: controller,
        ),
      ),
    );
  }
}
