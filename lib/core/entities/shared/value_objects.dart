

import 'package:cloud_firestore/cloud_firestore.dart';

class BirthDate{
  final DateTime date;

  BirthDate(this.date);

  static BirthDate fromTimestamp(Timestamp rawDate) {
    final date = rawDate.toDate();
    return BirthDate(date);
  }

}

class Name{
  final String value;

  Name(this.value);

}

class GroupId{
  final String groupId;

  GroupId(this.groupId);

  bool equals(GroupId id) {
    return groupId == id.groupId;
  }
}


class UserId{
  final String id;

  UserId(this.id);
}
