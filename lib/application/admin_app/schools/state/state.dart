import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

class SchoolState {
  final List<School> schools;
  final School? selectedSchool;
  final MonthlyPresenceStats? monthlyPresenceStats;

  SchoolState._(
      {this.selectedSchool, required this.schools, this.monthlyPresenceStats});

  factory SchoolState.initialState() {
    return SchoolState._(schools: []);
  }

  SchoolState copyWith(
      {List<School>? schools,
      School? selectedSchool,
      MonthlyPresenceStats? monthlyPresenceStats}) {
    return SchoolState._(
        schools: schools ?? this.schools,
        selectedSchool: selectedSchool ?? this.selectedSchool,
        monthlyPresenceStats:
            monthlyPresenceStats ?? this.monthlyPresenceStats);
  }
}
