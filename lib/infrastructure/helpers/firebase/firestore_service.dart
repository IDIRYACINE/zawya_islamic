import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zawya_islamic/infrastructure/ports/database_port.dart';

class FirestoreService implements DatabasePort {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  @override
  Future<VoidDatabaseResponse> create(CreateEntityOptions options) async {
    final path = options.metadata[OptionsMetadata.rootCollection];
    final firstId = options.metadata[OptionsMetadata.lastId];

    if (firstId != null) {
      _firestore.collection(path).doc(firstId).set(options.entity);
    } else {
      _firestore.collection(path).add(options.entity);
    }

    return DatabaseResponse(data: []);
  }

  @override
  Future<VoidDatabaseResponse> delete(DeleteEntityOptions options) async {
    final path = options.metadata[OptionsMetadata.rootCollection];
    final id = options.metadata[OptionsMetadata.lastId];

    _firestore.collection(path).doc(id).delete();
    return DatabaseResponse(data: []);
  }

  @override
  Future<DatabaseResponse<T>> read<T>(ReadEntityOptions options) async {
    final hasMany = options.metadata[OptionsMetadata.hasMany] ?? false;
    final path = options.metadata[OptionsMetadata.rootCollection];
    final id = options.metadata[OptionsMetadata.lastId];

    final parsedData = <T>[];

    if (!hasMany) {
      final rawSnapshot = await _firestore.collection(path).doc(id).get();

      final data = rawSnapshot.data();

      if (data != null) {
        parsedData.add(options.mapper(data));
      }
    } else {
      final rawSnapshot = await _firestore
          .collection(options.metadata[OptionsMetadata.rootCollection])
          .get();

      final List<T> data =
          rawSnapshot.docs.map((e) => options.mapper(e.data()) as T).toList();

      parsedData.addAll(data);
    }

    return DatabaseResponse(data: parsedData);
  }

  @override
  Future<VoidDatabaseResponse> update(UpdateEntityOptions options) async {
    final path = options.metadata[OptionsMetadata.rootCollection];
    final id = options.metadata[OptionsMetadata.lastId];

    _firestore.collection(path).doc(id).update(options.entity);

    return DatabaseResponse(data: []);
  }

  @override
  Future<DatabaseResponse<T>> searchText<T>(SearchTextEntityOptions options) {
    throw UnimplementedError();
  }
}
