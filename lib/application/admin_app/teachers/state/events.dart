import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

abstract class TeacherEvent {}

class CreateTeacherEvent extends TeacherEvent {
  final Teacher teacher;
  CreateTeacherEvent({required this.teacher});
}


class UpdateTeacherEvent extends TeacherEvent{
  final Teacher teacher;
  UpdateTeacherEvent({required this.teacher});
}

class DeleteTeacherEvent extends TeacherEvent{
  final Teacher teacher;

  DeleteTeacherEvent({required this.teacher});
}

class LoadTeachersEvent extends TeacherEvent{
  final List<Teacher> teachers;
  LoadTeachersEvent({required this.teachers});
}

class SetSchoolEvent extends TeacherEvent {
  final School school;
  SetSchoolEvent({required this.school});
}