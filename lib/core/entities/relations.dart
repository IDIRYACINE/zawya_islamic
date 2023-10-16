

import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';


class UserGroup{
  final UserId userId ;
  final GroupId groupId;

  UserGroup({required this.userId,required this.groupId});


  Map<String,dynamic> toMap(){
    return {
      UserGroupsTable.userId.name : userId.value,
      UserGroupsTable.groupId.name : groupId.value
    };
  }
}