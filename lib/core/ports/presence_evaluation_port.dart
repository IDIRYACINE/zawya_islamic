import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/session.dart';

import '../entities/presence.dart';

typedef GroupPresenceAndEvaluationResponse
    = PresenceAndEvaluationServiceResponse<PresenseAndEvaluationHolder>;

typedef SchoolPresenceAndEvaluationResponse
    = PresenceAndEvaluationServiceResponse<List<PresenseAndEvaluationHolder>>;

typedef MarkPresenceResponse = PresenceAndEvaluationServiceResponse<void>;
typedef MarkEvaluationResponse = PresenceAndEvaluationServiceResponse<void>;

class PresenseAndEvaluationHolder {
  final GroupId groupId;
  final List<Presence>? presences;
  final List<Evaluation>? evaluations;

  PresenseAndEvaluationHolder(
      {required this.groupId, this.presences, this.evaluations}) {
    assert(presences == null && evaluations == null,
        "Must load presences or evaluations or both");
  }
}

class PresenceAndEvaluationServiceResponse<T> {
  final String? message;
  final bool success;
  final T data;

  PresenceAndEvaluationServiceResponse(
      {this.message, this.success = true, required this.data});
}

abstract class PresenceAndEvaluationServiceOptions {}

class LoadSchoolPresenceAndEvaluationOptions
    extends PresenceAndEvaluationServiceOptions {
  final List<String>? groupsIds;
  final SchoolId schoolId;

  LoadSchoolPresenceAndEvaluationOptions(
      {required this.schoolId, this.groupsIds});
}

class LoadGroupPresenceAndEvaluationOptions
    extends PresenceAndEvaluationServiceOptions {
  final GroupId groupId;
  final SchoolId schoolId;

  LoadGroupPresenceAndEvaluationOptions(
      {required this.schoolId, required this.groupId});
}

class MarkPresenceOptions extends PresenceAndEvaluationServiceOptions {
  final Presence? presence;
  final List<Presence>? presences;
  final GroupId groupId;
  final SessionId sessionId;

  MarkPresenceOptions(
      {this.presence,
      this.presences,
      required this.sessionId,
      required this.groupId}) {
    assert(presence == null || presences == null,
        "Either presence or presences must be provided");
    assert((presences != null) && (presences?.isEmpty == true),
        "Presences is Empty");
  }
}

class MarkEvaluationOptions extends PresenceAndEvaluationServiceOptions {
  final Evaluation evaluation;
  final SchoolId schoolId;
  final GroupId groupId;

  MarkEvaluationOptions(
      {required this.evaluation,
      required this.schoolId,
      required this.groupId});
}

abstract class PresenceAndEvaluationServicePort {
  Future<GroupPresenceAndEvaluationResponse> loadGroupPresenceAndEvaluations(
      LoadGroupPresenceAndEvaluationOptions options);
  Future<SchoolPresenceAndEvaluationResponse> loadSchoolPresenceAndEvaluations(
      LoadSchoolPresenceAndEvaluationOptions options);
  Future<MarkPresenceResponse> markPresenceOrAbsence(
      MarkPresenceOptions options);
  Future<MarkEvaluationResponse> markMonthlyEvaluation(
      MarkEvaluationOptions options);
}
