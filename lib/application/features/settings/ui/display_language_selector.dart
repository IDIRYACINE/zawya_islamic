import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/menus.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/metadata.dart';
import 'package:flutter/material.dart';

typedef LocaleCallback = void Function(Locale locale);

class DisplayLanguageSelectorForm extends StatelessWidget {
  const DisplayLanguageSelectorForm({Key? key, required this.onConfirm})
      : super(key: key);

  final LocaleCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Locale> selectedLocale =
        ValueNotifier(AppMetadata.supportedLocales[0]);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DisplayLanguageSelector(
          selectedLanguage: (selectedLocale),
        ),
        const SizedBox(
          width: AppMeasures.space,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonPrimary(
              text: localizations.cancelLabel,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonPrimary(
              text: localizations.confirmLabel,
              onPressed: () {
                onConfirm(selectedLocale.value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class DisplayLanguageSelector extends StatelessWidget {
  const DisplayLanguageSelector({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);

  final ValueNotifier<Locale> selectedLanguage;

  DropdownMenuItem<Locale> localeDropdownAdapter(
      Locale locale, TextStyle textStyle) {
    return DropdownMenuItem<Locale>(
      value: locale,
      child: Text(
        locale.languageCode,
        style: textStyle,
      ),
    );
  }

  List<DropdownMenuItem<Locale>>? buildDropdown(
      List<Locale> languages, TextStyle textStyle) {
    List<DropdownMenuItem<Locale>>? items = [];
    for (Locale lang in languages) {
      items.add(localeDropdownAdapter(lang, textStyle));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle =
        theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary);

    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.selectLanguage,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(
          width: AppMeasures.space,
        ),
        Expanded(
          child: SelectorDropDown<Locale>(
              items: buildDropdown(AppMetadata.supportedLocales, textStyle),
              onSelect: (value) => selectedLanguage.value = value,
              initialSelection: selectedLanguage),
        )
      ],
    );
  }
}

class DisplayLanguageSelectorDialog extends StatelessWidget {
  const DisplayLanguageSelectorDialog({Key? key, required this.onConfirm})
      : super(key: key);

  final LocaleCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: DisplayLanguageSelectorForm(onConfirm: onConfirm),
    );
  }
}
