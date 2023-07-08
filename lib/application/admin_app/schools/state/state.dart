import 'package:zawya_islamic/core/aggregates/school.dart';

class SchoolState {
  final List<School> schools;
  final School? selectedSchool;

  SchoolState._({this.selectedSchool, required this.schools});

  factory SchoolState.initialState() {
    return SchoolState._(schools: []);
  }

  SchoolState copyWith({List<School>? schools, School? selectedSchool}) {
    return SchoolState._(
        schools: schools ?? this.schools,
        selectedSchool: selectedSchool ?? this.selectedSchool);
  }
}
