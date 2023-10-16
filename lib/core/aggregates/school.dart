import 'package:zawya_islamic/core/entities/shared/value_objects.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';


class SchoolId {
  final String value;

  SchoolId(this.value);

  bool equals(SchoolId id) {
    return value == id.value;
  }
}

class School {
  final SchoolId id;
  final Name name;

  School({required this.id, required this.name});

  School copyWith({Name? name}) {
    return School(id: id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {
      SchoolTable.schoolId.name: id.value,
      SchoolTable.schoolName.name: name.value,
    };
  }

  factory School.fromMap(Map<String, dynamic> json) {
    return School(
      id: SchoolId(json[SchoolTable.schoolId.name]),
      name: Name(json[SchoolTable.schoolName.name]),
    );
  }

  bool equals(School school) {
    return id.equals(school.id);
  }

  static School empty() {
    return School(id: SchoolId(''), name: Name(''));
  }
}

class SchoolsAggregate {
  final List<School> _schools;

  SchoolsAggregate(this._schools);

  List<School> addSchool(School school) {
    _schools.add(school);
    return _schools;
  }

  List<School> updateSchool(School school) {
    final index = _schools.indexWhere((element) => element.equals(school));
    if (index != -1) {
      _schools[index] = school;
    }
    return _schools;
  }

  List<School> deleteSchool(School school) {
    _schools.removeWhere((element) => element.equals(school));

    return _schools;
  }

  List<School> setSchools(List<School> schools) {
    _schools.clear();
    _schools.addAll(schools);
    return _schools;
  }

  List<School> get schools => _schools;
}
