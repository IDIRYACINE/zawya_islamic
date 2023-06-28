typedef EntityMapper<T> = T Function(Map<String, dynamic> data);


enum OptionsMetadata {
  path,
  id,
  hasMany,
  fullPath, nestedId,
}

enum DatabaseCollection{
  groups,
  users,
  teachers,
  schools, teacherGroups, groupStudents
}

abstract class DatabaseHandlerOptions {}

class CreateEntityOptions extends DatabaseHandlerOptions {
  final Map<String, dynamic> entity;
  final Map<OptionsMetadata, dynamic> metadata;

  CreateEntityOptions(this.entity, this.metadata);
}

class UpdateEntityOptions extends DatabaseHandlerOptions {
  final Map<String, dynamic> entity;
  final Map<OptionsMetadata, dynamic> metadata;

  UpdateEntityOptions(this.entity, this.metadata);
  }

class DeleteEntityOptions extends DatabaseHandlerOptions {
  final Map<OptionsMetadata, dynamic> metadata;

  DeleteEntityOptions(this.metadata);
}

class ReadEntityOptions extends DatabaseHandlerOptions {
  final Map<OptionsMetadata, dynamic> metadata;
  final EntityMapper mapper;


  ReadEntityOptions(this.metadata,this.mapper);
}

class DatabaseResponse<T> {
  final List<T> data;
  final String? message;
  final bool success;

  DatabaseResponse({required this.data, this.message, this.success = true});
}

typedef VoidDatabaseResponse = DatabaseResponse<void>;

abstract class DatabasePort {
  Future<VoidDatabaseResponse> create(CreateEntityOptions options);
  Future<VoidDatabaseResponse> update(UpdateEntityOptions options);
  Future<VoidDatabaseResponse> delete(DeleteEntityOptions options);
  Future<DatabaseResponse<T>> read<T>(ReadEntityOptions options);
}
