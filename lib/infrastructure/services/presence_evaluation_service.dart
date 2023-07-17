import 'package:zawya_islamic/core/ports/presence_evaluation_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class PresenceAndEvaluationService implements PresenceAndEvaluationServicePort {
  final DatabasePort databaseService;

  PresenceAndEvaluationService(this.databaseService);

  @override
  Future<GroupPresenceAndEvaluationResponse> loadGroupPresenceAndEvaluations(
      LoadGroupPresenceAndEvaluationOptions options) {
    throw UnimplementedError();
  }

  @override
  Future<SchoolPresenceAndEvaluationResponse> loadSchoolPresenceAndEvaluations(
      LoadSchoolPresenceAndEvaluationOptions options) {
    throw UnimplementedError();
  }

  @override
  Future<MarkEvaluationResponse> markMonthlyEvaluation(
      MarkEvaluationOptions options) {
    throw UnimplementedError();
  }

  @override
  Future<MarkPresenceResponse> markPresenceOrAbsence(
      MarkPresenceOptions options) {
    throw UnimplementedError();
  }
}
