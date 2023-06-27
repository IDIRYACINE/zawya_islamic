import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({Key? key, required this.onPressed,this.width, required this.text})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return MaterialButton(
      minWidth: width,
      color: theme.colorScheme.primary,
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}

class GenericFormActions extends StatelessWidget {
  const GenericFormActions(
      {Key? key, required this.onConfirmPressed, required this.onCancelPressed})
      : super(key: key);

  final VoidCallback onConfirmPressed;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        ButtonPrimary(
          onPressed: onCancelPressed,
          text: localizations.cancelLabel,
        ),
        ButtonPrimary(
          onPressed: onConfirmPressed,
          text: localizations.confirmLabel,
        ),
      ],
    );
  }
}
