
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class SchoolService implements SchoolServicePort{
    final DatabasePort _databaseService;

  SchoolService(this._databaseService);

  @override
  Future<DeleteSchoolResponse> deleteSchool(DeleteSchoolOptions options) {
    // TODO: implement deleteSchool
    throw UnimplementedError();
  }

  @override
  Future<LoadSchoolResponse> getSchool(LoadSchoolOptions options) {
    // TODO: implement getSchool
    throw UnimplementedError();
  }

  @override
  Future<LoadSchoolsResponse> getSchools(LoadSchoolsOptions options) {
    // TODO: implement getSchools
    throw UnimplementedError();
  }

  @override
  Future<RegisterSchoolResponse> registerSchool(RegisterSchoolOptions options) {
    // TODO: implement registerSchool
    throw UnimplementedError();
  }

  @override
  Future<UpdateSchoolResponse> updateSchool(UpdateSchoolOptions options) {
    // TODO: implement updateSchool
    throw UnimplementedError();
  }

}