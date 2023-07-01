

import 'package:zawya_islamic/core/entities/shared/value_objects.dart';

enum StudentAttributes{
  id,
  name,
  birthDate,}

class StudentId{
  final String value;

  StudentId(this.value);
  
  bool equals(StudentId id) {
    return value == id.value;
  }
  
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

  Student copyWith({
    StudentId? id,
    Name? name,
    BirthDate? birthDate,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  bool equals(Student student) {
    return id.equals(student.id);
  }

}