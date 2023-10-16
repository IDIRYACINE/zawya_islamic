import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

abstract class SchoolEvent {}

class SetMonthlyPresenceStats extends SchoolEvent {
  final MonthlyPresenceStats? monthlyPresenceStats;
  SetMonthlyPresenceStats({
    this.monthlyPresenceStats,
  }) ;
}

class CreateSchoolEvent extends SchoolEvent {
  final School school;
  CreateSchoolEvent({required this.school});
}

class UpdateSchoolEvent extends SchoolEvent {
  final School school;
  UpdateSchoolEvent({required this.school});
}

class DeleteSchoolEvent extends SchoolEvent {
  final School school;

  DeleteSchoolEvent({required this.school});
}

class LoadSchoolsEvent extends SchoolEvent {
  final List<School> schools;
  LoadSchoolsEvent({required this.schools});
}

class SelectSchoolEvent extends SchoolEvent {
  final School school;

  SelectSchoolEvent({required this.school});
}
