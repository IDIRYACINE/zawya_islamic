typedef EntityMapper<T> = T Function(Map<String, dynamic> data);

enum OptionsMetadata {
  rootCollection,
  lastId,
  hasMany,
  fullPath,
  firstId,
  lastCollection,
  order,
  searchColumn,
  searchQuery,
}

enum SearchLanguage { arabic, english }

enum DatabaseCollection {
  groups,
  users,
  userGroups,
  schools,
  userRoles,
  studentEvaluations,
  groupSchedules,
  groupScheduleOrderd,
  monthlyPresence
}

enum DatabaseViews {
  groupStudents,
  teacherGroups,
  schoolStudents,
  groupStudentEvaluations,
  studentGroups,
  groupAttendanceStatistics
}

extension DatabaseCollectionExtension on DatabaseCollection {
  String get code {
    switch (this) {
      case DatabaseCollection.groups:
        return "g";

      default:
        return "s";
    }
  }
}

class DatabaseEntry {
  final String key;
  final String value;

  DatabaseEntry(this.key, this.value);
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
  final Map<String, dynamic> filters;

  UpdateEntityOptions(
      {required this.entity, required this.metadata, required this.filters});
}

class DeleteEntityOptions extends DatabaseHandlerOptions {
  final Map<OptionsMetadata, dynamic> metadata;
  final Map<String, dynamic> entries;

  DeleteEntityOptions({required this.metadata, required this.entries});
}

class ReadEntityOptions extends DatabaseHandlerOptions {
  final Map<OptionsMetadata, dynamic> metadata;
  final EntityMapper mapper;
  final Map<String, dynamic>? filters;

  ReadEntityOptions(
      {required this.metadata, required this.mapper, this.filters});
}

class SearchTextEntityOptions extends DatabaseHandlerOptions {
  final Map<OptionsMetadata, dynamic> metadata;
  final EntityMapper mapper;
  final Map<String, dynamic>? filters;
  final SearchLanguage language;

  SearchTextEntityOptions(
      {required this.metadata,
      required this.mapper,
      this.language = SearchLanguage.arabic,
      this.filters});
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
  Future<DatabaseResponse<T>> searchText<T>(SearchTextEntityOptions options);
}
