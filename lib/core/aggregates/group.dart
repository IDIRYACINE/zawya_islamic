import 'package:zawya_islamic/core/entities/export.dart';

class Group {
  final GroupId group;

  final Name name;

  Group({required this.group, required this.name});


  factory Group.fromMap(Map<String,dynamic> json){
    return Group(
      group: GroupId(json['group']),
      name: Name(json['name']),
    );
  }
}
