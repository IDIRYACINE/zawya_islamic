import 'package:firebase_database/firebase_database.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class FirebaseDatabaseService implements DatabasePort {
  final FirebaseDatabase _firebaseDatabase;

  FirebaseDatabaseService(this._firebaseDatabase);

  @override
  Future<VoidDatabaseResponse> create(CreateEntityOptions options) async {
    final path = options.metadata[OptionsMetadata.rootCollection.name];
    final id = options.metadata[OptionsMetadata.lastId.name];

    _firebaseDatabase.ref().child(path).child(id).set(options.entity);
    return DatabaseResponse(data: []);
  }

  @override
  Future<VoidDatabaseResponse> delete(DeleteEntityOptions options) async {
    final path = options.metadata[OptionsMetadata.rootCollection];
    final id = options.metadata[OptionsMetadata.lastId];

    _firebaseDatabase.ref().child(path).child(id).remove();
    return DatabaseResponse(data: []);
  }

  @override
  Future<DatabaseResponse<T>> read<T>(ReadEntityOptions options) async {
    final parsedData = <T>[];
    final path = options.metadata[OptionsMetadata.rootCollection];
    final id = options.metadata[OptionsMetadata.lastId];
    final hasMany = options.metadata[OptionsMetadata.hasMany] ?? false;

    if (!hasMany) {
      final rawSnapshot =
          await _firebaseDatabase.ref().child(path).child(id).once();

      final data = rawSnapshot.snapshot.value as Map<String, dynamic>?;

      if (data != null) {
        parsedData.add(options.mapper(data));
      }
    } else {
      final rawSnapshot = await _firebaseDatabase.ref().child(path).once();

      final temp = rawSnapshot.snapshot.value as Map<String, dynamic>?;

      final data = temp?.values.map((e) => options.mapper(e)).toList();

      parsedData.addAll(data as Iterable<T>);
    }

    return DatabaseResponse(data: []);
  }

  @override
  Future<VoidDatabaseResponse> update(UpdateEntityOptions options) async {
    final path = options.metadata[OptionsMetadata.rootCollection];
    final id = options.metadata[OptionsMetadata.lastId];

    _firebaseDatabase.ref().child(path).child(id).update(options.entity);
    return DatabaseResponse(data: []);
  }

  @override
  Future<DatabaseResponse<T>> searchText<T>(SearchTextEntityOptions options) {
    throw UnimplementedError();
  }
}
