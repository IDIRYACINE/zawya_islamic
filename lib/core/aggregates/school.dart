

import 'package:zawya_islamic/core/entities/shared/value_objects.dart';

enum SchoolAttributes{
  id,
  name,
}

class SchoolId{
  final int id;

  SchoolId(this.id);

  
}

class School{
  final SchoolId id;
  final Name name;

  School({required this.id, required this.name});

  Map<String,dynamic> toMap(){
    return {
      SchoolAttributes.id.name : id.id,
      SchoolAttributes.name.name : name.name,
    };
  }

  factory School.fromMap(Map<String,dynamic> json){
    return School(
      id: SchoolId(json[SchoolAttributes.id.name]),
      name: Name(json[SchoolAttributes.name.name]),
    );
  }
}