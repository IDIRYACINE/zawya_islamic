

import 'package:zawya_islamic/core/entities/shared/value_objects.dart';

class AdminId{
  final int value;

  AdminId(this.value);


}
class Admin{
  final AdminId id;
  final Name name;

  Admin({required this.id,required this.name});
}