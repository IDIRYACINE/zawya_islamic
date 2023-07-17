import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class SupabasePostrgessService implements DatabasePort {
  final SupabaseClient _client;

  SupabasePostrgessService(this._client);

  @override
  Future<VoidDatabaseResponse> create(CreateEntityOptions options) async {

    print("inside");
    await _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .insert(options.entity).onError((e,stack) => print(e.toString()));

    return DatabaseResponse(data: []);
  }

  @override
  Future<VoidDatabaseResponse> delete(DeleteEntityOptions options) async {
    _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .delete()
        .match(options.entries);

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
          .match(options.filters!))
          
          ;
    } else {
      rawData = await _client
          .from(options.metadata[OptionsMetadata.rootCollection])
          .select("*");

    }

    if (!hasMany) {
      parsedData.add(options.mapper(rawData.first));
    } else {
      final List<T> data =
          rawData.map((e) => options.mapper(e) as T).toList();

      parsedData.addAll(data);
    }

    return DatabaseResponse(data: parsedData);
  }

  @override
  Future<VoidDatabaseResponse> update(UpdateEntityOptions options) async {
    _client
        .from(options.metadata[OptionsMetadata.rootCollection])
        .update(options.entity)
        .match(options.filters);

    return DatabaseResponse(data: []);
  }
}
