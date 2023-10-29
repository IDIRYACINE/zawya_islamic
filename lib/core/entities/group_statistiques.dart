import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class Stat {
  late final int value;

  Stat(int statValue) {
    if (statValue < 0) {
      throw Exception("Stat value must be positive");
    }
    value = statValue;
  }
}

class GroupStatistiques {
  final Group group;
  final Stat presence;
  final Stat absence;
  final Stat discipline;
  final Stat chaotic;

  factory GroupStatistiques.fromMap(Map<String, dynamic> json) {
    return GroupStatistiques(
      group: Group.fromMap(json),
      presence: Stat(json[GroupsStatistiquesTable.presence.name]),
      absence: Stat(json[GroupsStatistiquesTable.absence.name]),
      discipline: Stat(json[GroupsStatistiquesTable.discipline.name]),
      chaotic: Stat(json[GroupsStatistiquesTable.chaotic.name]),
    );
  }

  GroupStatistiques(
      {required this.group,
      required this.presence,
      required this.absence,
      required this.discipline,
      required this.chaotic});
}
