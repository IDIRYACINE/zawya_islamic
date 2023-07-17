import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/database_tables_port.dart';

class SchoolService implements SchoolServicePort {
  final DatabasePort _databaseService;

  SchoolService(this._databaseService);

  @override
  Future<DeleteSchoolResponse> deleteSchool(DeleteSchoolOptions options) async {
    final dbOptions = DeleteEntityOptions(
        metadata: {OptionsMetadata.rootCollection: DatabaseCollection.groups},
        entries: {SchoolTable.schoolId.name: options.schoolId.value});

    _databaseService.delete(dbOptions);

    return DeleteSchoolResponse(data: null);
  }

  @override
  Future<LoadSchoolResponse> getSchool(LoadSchoolOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection: DatabaseCollection.schools.name,
      OptionsMetadata.lastId: options.schoolId.value,
      OptionsMetadata.hasMany: false,
    }, School.fromMap);

    final response = await _databaseService.read(dbOptions);

    return LoadSchoolResponse(data: response.data.first);
  }

  @override
  Future<LoadSchoolsResponse> getSchools(LoadSchoolsOptions options) async {
    final dbOptions = ReadEntityOptions({
      OptionsMetadata.rootCollection: DatabaseCollection.schools.name,
      OptionsMetadata.hasMany: true,
    }, School.fromMap);

    final response = await _databaseService.read<School>(dbOptions);

    return LoadSchoolsResponse(data: response.data);
  }

  @override
  Future<RegisterSchoolResponse> registerSchool(
      RegisterSchoolOptions options) async {

    final dbOptions = CreateEntityOptions(options.school.toMap(), {
      OptionsMetadata.rootCollection: DatabaseCollection.schools.name,
      OptionsMetadata.lastId: options.school.id.value,
    });

    _databaseService.create(dbOptions);

    return RegisterSchoolResponse(data: null);
  }

  @override
  Future<UpdateSchoolResponse> updateSchool(UpdateSchoolOptions options) async {
    final dbOptions = UpdateEntityOptions(
      entity:options.school.toMap(),metadata:{
      OptionsMetadata.rootCollection: DatabaseCollection.schools.name,
      OptionsMetadata.lastId: options.school.id.value,
    },
    
    filters: {
      SchoolTable.schoolId.name : options.school.id.value
    }
    );

    _databaseService.update(dbOptions);

    return UpdateSchoolResponse(data: null);
  }
}
