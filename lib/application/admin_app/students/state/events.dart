import 'package:zawya_islamic/core/entities/export.dart';

abstract class StudentEvent {}

class CreateStudentEvent extends StudentEvent {
  final Student student;
  CreateStudentEvent({required this.student});
}


class UpdateStudentEvent extends StudentEvent{
  final Student student;
  UpdateStudentEvent({required this.student});
}

class DeleteStudentEvent extends StudentEvent{
  final Student student;

  DeleteStudentEvent({required this.student});
}

class LoadStudentsEvent extends StudentEvent{
  final List<Student> students;
  LoadStudentsEvent({required this.students});
}