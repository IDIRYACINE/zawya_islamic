import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';

import 'buttons.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
    );
  }
}

class OptionsButton extends StatelessWidget {
  const OptionsButton({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onClick, icon: const Icon(AppResources.optionsIcon,color: Colors.white,));
  }
}

class OptionsAlertDialog extends StatelessWidget {
  const OptionsAlertDialog({super.key, required this.options});

  final List<OptionsButtonData> options;

  Widget _buildItem(BuildContext context, int index) {
    OptionsButtonData option = options[index];

    return ButtonPrimary(onPressed: option.callback, text: option.title);
  }

  Widget _buildSeperator(BuildContext context, int index) {
    return const SizedBox(
      height: AppMeasures.space,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      content: SizedBox(
        height: size.height / 2,
        width: size.width / 2,
        child: ListView.separated(
          itemBuilder: _buildItem,
          separatorBuilder: _buildSeperator,
          itemCount: options.length,
        ),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,
      required this.onConfirm,
      required this.content,
      required this.title});

  final VoidCallback onConfirm;
  final String content;
  final String title;

  void _onCancel() {
    NavigationService.pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: _onCancel,
          child: Text(localizations.cancelLabel),
        ),
        ButtonPrimary(onPressed: onConfirm, text: localizations.confirmLabel),
      ],
    );
  }
}
