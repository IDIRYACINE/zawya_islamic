import 'package:zawya_islamic/core/aggregates/school.dart';



class SchoolState {
  final List<School> schools;


  SchoolState._({required this.schools}) ;

  factory SchoolState.initialState() {
    return SchoolState._(schools: []);
  }

  SchoolState copyWith({List<School>? schools}) {
    return SchoolState._(schools: schools ?? this.schools);
  }
}
