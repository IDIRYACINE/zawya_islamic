

import 'package:zawya_islamic/core/entities/shared/value_objects.dart';

enum StudentAttributes{
  id,
  name,
  birthDate,}

class StudentId{
  final int value;

  StudentId(this.value);
  
}

class Student{
  final StudentId id;
  final Name name;
  final BirthDate birthDate;

  Student({required this.id,required  this.name,required  this.birthDate});

  factory Student.fromMap(Map<String,dynamic> json){
    return Student(
      id: StudentId(json[StudentAttributes.id.name]),
      name: Name(json[StudentAttributes.name.name]),
      birthDate: BirthDate(json[StudentAttributes.birthDate.name]),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      StudentAttributes.id.name : id.value,
      StudentAttributes.name.name : name.value,
      StudentAttributes.birthDate.name : birthDate.date,
    };
  }

}