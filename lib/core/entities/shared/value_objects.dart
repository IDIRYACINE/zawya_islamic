

class BirthDate{
  final DateTime date;

  BirthDate(this.date);

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
