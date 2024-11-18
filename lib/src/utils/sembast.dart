import 'package:sembast/sembast.dart';

abstract class IntStore<T> extends Store<int, T> {
  const IntStore(
    super.store, {
    super.idKey,
  });

  @override
  Future<int> generateKey(DatabaseClient databaseClient) {
    return store.generateIntKey(databaseClient);
  }
}

abstract class StringStore<T> extends Store<String, T> {
  const StringStore(
    super.store, {
    super.idKey,
  });

  @override
  Future<String> generateKey(DatabaseClient databaseClient) {
    return store.generateKey(databaseClient);
  }
}

sealed class Store<K, T> {
  const Store(
    this.store, {
    this.idKey = 'id',
  });

  final StoreRef<K, Map<String, dynamic>> store;
  final String idKey;

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T object);

  Future<K> generateKey(DatabaseClient databaseClient);

  Future<K?> add(
    DatabaseClient databaseClient,
    T object,
  ) {
    final value = toJson(object);
    final key = value[idKey] as K?;

    return addMap(databaseClient, key, value);
  }

  Future<K?> addMap(
    DatabaseClient databaseClient,
    K? key,
    Map<String, dynamic> value,
  ) {
    if (key is K) {
      final record = store.record(key);
      return record.add(databaseClient, value);
    } //
    else {
      return store.add(databaseClient, value);
    }
  }

  Future<T?> update(
    DatabaseClient databaseClient,
    T object,
  ) async {
    final value = toJson(object);
    final id = value[idKey] as K;

    final result = await updateMap(databaseClient, id, value);
    return result == null ? null : _fromRecord(id, result);
  }

  Future<Map<String, dynamic>?> updateMap(
    DatabaseClient databaseClient,
    K key,
    Map<String, dynamic> value,
  ) {
    final record = store.record(key);
    return record.update(databaseClient, value);
  }

  Future<T> put(
    DatabaseClient databaseClient,
    T object, {
    bool? merge,
    bool? ifNotExists,
  }) {
    final value = toJson(object);
    final id = value[idKey] as K;

    return putMap(databaseClient, id, value, merge: merge, ifNotExists: ifNotExists) //
        .then((v) => _fromRecord(id, v));
  }

  Future<Map<String, dynamic>> putMap(
    DatabaseClient databaseClient,
    K key,
    Map<String, dynamic> value, {
    bool? merge,
    bool? ifNotExists,
  }) {
    final record = store.record(key);
    return record.put(databaseClient, value, merge: merge, ifNotExists: ifNotExists);
  }

  Future<K?> delete(
    DatabaseClient databaseClient,
    K key,
  ) {
    final record = store.record(key);
    return record.delete(databaseClient);
  }

  Stream<List<T>> query(
    Database database, {
    Finder? finder,
  }) {
    return queryMap(database, finder: finder) //
        .map(_fromRecordSnapshots);
  }

  Stream<List<RecordSnapshot<K, Map<String, dynamic>>>> queryMap(
    Database database, {
    Finder? finder,
  }) {
    return store //
        .query(finder: finder)
        .onSnapshots(database);
  }

  Future<List<T>> find(
    DatabaseClient databaseClient, {
    Finder? finder,
  }) {
    return findMap(databaseClient, finder: finder) //
        .then(_fromRecordSnapshots);
  }

  Future<List<RecordSnapshot<K, Map<String, dynamic>>>> findMap(
    DatabaseClient databaseClient, {
    Finder? finder,
  }) {
    return store.find(databaseClient, finder: finder);
  }

  List<T> _fromRecordSnapshots(Iterable<RecordSnapshot<K, Map<String, dynamic>>> records) {
    return records.map(_fromRecordSnapshot).toList(growable: false);
  }

  T _fromRecordSnapshot(RecordSnapshot<K, Map<String, dynamic>> record) {
    return _fromRecord(record.key, record.value);
  }

  T _fromRecord(K key, Map<String, dynamic> value) {
    return fromJson({'id': key, ...value});
  }
}
