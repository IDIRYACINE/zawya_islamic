
import 'shared/value_objects.dart';

class TeacherId{
  final int id;

  TeacherId(this.id);

}

class Teacher{
  final TeacherId id;
  final Name name;
  final List<GroupId> groups;

  Teacher({required this.id,required  this.name,required this.groups});
}