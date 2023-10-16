import 'package:zawya_islamic/application/admin_app/schools/export.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

Future<void> loadMonthlyPresenceStats(
    SchoolsBloc bloc, SchoolId? schoolId) async {
  if (schoolId == null) {
    return;
  }

  final options = MonthlyPresenceOptions(schoolId: schoolId);

  ServicesProvider.instance().schoolService.getMonthlyPresence(options).then(
      (res) =>
          bloc.add(SetMonthlyPresenceStats(monthlyPresenceStats: res.data)));
}

bool invalidSchoolStats(
    SchoolId? selectedSchoolId, SchoolId? monthlyPresenceSchoolId) {
  if ((selectedSchoolId == null) || (monthlyPresenceSchoolId == null)) {
    return true;
  }
  return !selectedSchoolId.equals(monthlyPresenceSchoolId);
}
