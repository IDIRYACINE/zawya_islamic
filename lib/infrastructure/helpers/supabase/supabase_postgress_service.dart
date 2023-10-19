import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';
import 'package:zawya_islamic/infrastructure/ports/logger_port.dart';

class SupabasePostrgessService implements DatabasePort {
  final SupabaseClient _client;
  final LoggerServicePort _logger;

  SupabasePostrgessService(this._client, this._logger);

  @override
  Future<VoidDatabaseResponse> create(CreateEntityOptions options) async {
    await _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .insert(options.entity)
        .onError((error, stackTrace) => _logger.log("postgress/insert",
            error: error, stackTrace: stackTrace));

    return DatabaseResponse(data: []);
  }

  @override
  Future<VoidDatabaseResponse> delete(DeleteEntityOptions options) async {
    _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .delete()
        .match(options.entries)
        .onError((error, stackTrace) => _logger.log("postgress/delete",
            error: error, stackTrace: stackTrace));

    return DatabaseResponse(data: []);
  }

  @override
  Future<DatabaseResponse<T>> read<T>(ReadEntityOptions options) async {
    final parsedData = <T>[];
    final hasMany = options.metadata[OptionsMetadata.hasMany] ?? false;

    List<dynamic> rawData;

    if (options.filters != null) {
      rawData = (await _client
          .from(options.metadata[OptionsMetadata.rootCollection])
          .select('*')
          .match(options.filters!));
    } else {
      rawData = await _client
          .from(options.metadata[OptionsMetadata.rootCollection])
          .select("*");
    }

    if (!hasMany) {
      parsedData.add(options.mapper(rawData.first));
    } else {
      final List<T> data = rawData.map((e) => options.mapper(e) as T).toList();

      parsedData.addAll(data);
    }

    return DatabaseResponse(data: parsedData);
  }

  @override
  Future<VoidDatabaseResponse> update(UpdateEntityOptions options) async {
    _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .update(options.entity)
        .match(options.filters)
        .onError((error, stackTrace) => _logger.log("postgress/delete",
            error: error, stackTrace: stackTrace));

    return DatabaseResponse(data: []);
  }

  @override
  Future<DatabaseResponse<T>> searchText<T>(
      SearchTextEntityOptions options) async {
    final parsedData = <T>[];
    final column = options.metadata[OptionsMetadata.searchColumn];
    final query = options.metadata[OptionsMetadata.searchQuery];
    List<dynamic> rawData;

    rawData = (await _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .select('*')
        .match(options.filters!)
        .textSearch(column, query, config: "arabic"));

    final List<T> data = rawData.map((e) => options.mapper(e) as T).toList();

    parsedData.addAll(data);

    return DatabaseResponse(data: parsedData);
  }
}
