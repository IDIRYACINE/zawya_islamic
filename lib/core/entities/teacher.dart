
import 'shared/value_objects.dart';

enum TeacherAttributes{
  id,
  name,
  groups,
}

class TeacherId{
  final int id;

  TeacherId(this.id);

}

class Teacher{
  final TeacherId id;
  final Name name;
  final List<GroupId> groups;

  Teacher({required this.id,required  this.name,required this.groups});

  factory Teacher.fromMap(Map<String,dynamic> json){
    return Teacher(
      id: TeacherId(json[TeacherAttributes.id.name]),
      name: Name(json[TeacherAttributes.name.name]),
      groups: List<GroupId>.from(json[TeacherAttributes.groups.name].map((x) => GroupId(x))),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      TeacherAttributes.id.name : id.id,
      TeacherAttributes.name.name : name.name,
      TeacherAttributes.groups.name : List<dynamic>.from(groups.map((x) => x.groupId)),
    };
  }

  
}