import 'package:zawya_islamic/resources/l10n/l10n.dart';

String? schoolNameValidator(String? value,AppLocalizations localizations) {
  
  if (value == null) {
    return localizations.emptyFieldError;
  }

  RegExp regExp = RegExp(r'^[A-Za-z\s]+$');

  if (!regExp.hasMatch(value)) {
    return localizations.onlyCharactersAllowed;
  }

  return null;
}
