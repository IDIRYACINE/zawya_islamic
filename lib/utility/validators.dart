import 'package:zawya_islamic/resources/l10n/l10n.dart';

String? schoolNameValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  RegExp regExp = RegExp(r'^[A-Za-z]+\s?(\d*|[A-Za-z]+)?$');

  if (!regExp.hasMatch(value)) {
    return localizations.onlyCharactersAllowed;
  }

  return null;
}

String? dateValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  RegExp regExp = RegExp(r'^\d{2}\/\d{2}\/\d{4}$');

  if (!regExp.hasMatch(value)) {
    return localizations.invalidDateFormat;
  }

  return null;
}

String? studentNameValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  RegExp regExp = RegExp(r'^[A-Za-z]+\s[A-Za-z]+$');

  if (!regExp.hasMatch(value)) {
    return localizations.onlyCharactersAllowed;
  }

  return null;
}

String? teacherNameValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  RegExp regExp = RegExp(r'^[A-Za-z]+\s[A-Za-z]+$');

  if (!regExp.hasMatch(value)) {
    return localizations.onlyCharactersAllowed;
  }

  return null;
}

String? groupNameValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  RegExp regExp = RegExp(r'^[A-Za-z]+\s?(\d*|[A-Za-z]+)?$');

  if (!regExp.hasMatch(value)) {
    return localizations.onlyCharactersAllowed;
  }

  return null;
}

String? suratFormValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  if (int.tryParse(value) == null) {
    return "Only Numbers";
  }

  return null;
}

String? ayatFormValidator(
    String? value, int ayatCount, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  final n = int.tryParse(value);

  if (n == null) {
    return "Only Numbers";
  }

  if (n < 0 || n > ayatCount) {
    return "Ayat doesn't exists";
  }

  return null;
}


String? emailValidator(String? value, AppLocalizations localizations) {
  String? isEmpty = emptyValidator(value,localizations);
  if(isEmpty !=null){
    return isEmpty;
  }


  return null;
}


String? passwordValidator(String? value, AppLocalizations localizations) {
  if (value == null) {
    return localizations.emptyFieldError;
  }

  if (value.length < 6) {
    return "Must be more than 6 characters";
  }

  return null;
}

String? emptyValidator (String? value, AppLocalizations localizations) {
  if (value == null || value=="") {
    return localizations.emptyFieldError;
  }

  return null;
}