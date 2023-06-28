import 'package:zawya_islamic/core/entities/export.dart';

enum GroupAttributes{
  id,
  name,

}

class Group {
  final GroupId id;

  final Name name;

  Group({required this.id, required this.name});

  Map<String,dynamic> toMap(){
    return {
      GroupAttributes.id.name : id.groupId,
      GroupAttributes.name.name : name.name,
    };
  }


  factory Group.fromMap(Map<String,dynamic> json){
    return Group(
      id: GroupId(json['group']),
      name: Name(json['name']),
    );
  }
}
