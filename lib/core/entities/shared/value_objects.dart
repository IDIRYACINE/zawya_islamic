

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
  final String value;

  GroupId(this.value);

  bool equals(GroupId id) {
    return value == id.value;
  }
}


class UserId{
  final String value;

  UserId(this.value);
}
