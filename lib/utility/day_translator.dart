import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';

class DayIdTranslator {
  final AppLocalizations localizations;

  DayIdTranslator(this.localizations);

  String getDayFromId(DayId id) {
    String day;

    switch (id.value) {
      case 0:
        day = localizations.saturday;
        break;
      case 1:
        day = localizations.sunday;
        break;
      case 2:
        day = localizations.monday;
        break;
      case 3:
        day = localizations.tuesday;
        break;
      case 4:
        day = localizations.wednesday;
        break;
      case 5:
        day = localizations.thursday;
        break;
      default:
        day = localizations.friday;
    }

    return day;
  }
}
