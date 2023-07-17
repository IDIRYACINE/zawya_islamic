
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

import 'shared/value_objects.dart';


class TeacherId{
  final String value;

  TeacherId(this.value);
  
  bool equals(TeacherId id) {
    return value == id.value;
  }

}

class Teacher{
  final TeacherId id;
  final Name name;
  final List<GroupId> groups;

  Teacher({required this.id,required  this.name,required this.groups});

  factory Teacher.fromMap(Map<String,dynamic> json){
    return Teacher(
      id: TeacherId(json[UserTable.userId.name]),
      name: Name(json[UserTable.userName.name]),
      groups: [],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      UserTable.userId.name : id.value,
      UserTable.userName.name : name.value,
    };
  }

  Teacher copyWith({ Name? name , List<GroupId>? groups}) {
    return Teacher(
      id: id,
      name: name ?? this.name,
      groups: groups ?? this.groups,
    );
  }

  bool equals(Teacher teacher) {
    return id.equals(teacher.id);
  }

  
}