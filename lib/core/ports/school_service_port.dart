import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';

typedef LoadSchoolsResponse = SchoolServiceResponse<List<School>>;
typedef LoadSchoolResponse = SchoolServiceResponse<School>;
typedef RegisterSchoolResponse = SchoolServiceResponse<void>;
typedef UpdateSchoolResponse = SchoolServiceResponse<void>;
typedef DeleteSchoolResponse = SchoolServiceResponse<void>;
typedef MonyltyPresenceResponse = SchoolServiceResponse<MonthlyPresenceStats>;

class SchoolServiceResponse<T> {
  final String? message;
  final bool success;
  final T data;

  SchoolServiceResponse(
      {this.message, this.success = true, required this.data});
}

abstract class SchoolServiceOptions {}

class LoadSchoolsOptions extends SchoolServiceOptions {
  final List<SchoolId> schoolIds;

  LoadSchoolsOptions({this.schoolIds = const []});
}

class LoadSchoolOptions extends SchoolServiceOptions {
  final SchoolId schoolId;

  LoadSchoolOptions({required this.schoolId});
}

class RegisterSchoolOptions extends SchoolServiceOptions {
  final School school;

  RegisterSchoolOptions({required this.school});
}

class UpdateSchoolOptions extends SchoolServiceOptions {
  final School school;

  UpdateSchoolOptions({required this.school});
}

class DeleteSchoolOptions extends SchoolServiceOptions {
  final SchoolId schoolId;

  DeleteSchoolOptions({required this.schoolId});
}

class MonthlyPresenceOptions extends SchoolServiceOptions {
  final SchoolId schoolId;

  MonthlyPresenceOptions({required this.schoolId});
}

abstract class SchoolServicePort {
  Future<LoadSchoolResponse> getSchool(LoadSchoolOptions options);
  Future<LoadSchoolsResponse> getSchools(LoadSchoolsOptions options);
  Future<RegisterSchoolResponse> registerSchool(RegisterSchoolOptions options);
  Future<UpdateSchoolResponse> updateSchool(UpdateSchoolOptions options);
  Future<DeleteSchoolResponse> deleteSchool(DeleteSchoolOptions options);
  Future<MonyltyPresenceResponse> getMonthlyPresence(MonthlyPresenceOptions options);
}
