

import 'package:zawya_islamic/core/entities/shared/value_objects.dart';

class StudentId{
  final int value;

  StudentId(this.value);
  
}

class Student{
  final StudentId id;
  final Name name;
  final BirthDate birthDate;

  Student({required this.id,required  this.name,required  this.birthDate});


}