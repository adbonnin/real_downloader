import 'package:sembast/sembast.dart';

abstract class IntMapStore<T> extends MapStore<int, T> {
  const IntMapStore(super.store);

  @override
  Future<int> generateKey(DatabaseClient databaseClient) {
    return store.generateIntKey(databaseClient);
  }
}

abstract class StringMapStore<T> extends MapStore<String, T> {
  const StringMapStore(super.store);

  @override
  Future<String> generateKey(DatabaseClient databaseClient) {
    return store.generateKey(databaseClient);
  }
}

sealed class MapStore<K, T> {
  const MapStore(this.store);

  final StoreRef<K, Map<String, dynamic>> store;

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T object);

  Future<K> generateKey(DatabaseClient databaseClient);

  Future<K?> add(DatabaseClient databaseClient, T object) {
    final value = toJson(object);
    final key = value['id'];

    if (key is K) {
      final record = store.record(key);
      return record.add(databaseClient, value);
    } //
    else {
      return store.add(databaseClient, value);
    }
  }

  Future<T?> update(DatabaseClient databaseClient, T object) async {
    final value = toJson(object);
    final key = value['id'];

    final record = store.record(key);
    final result = await record.update(databaseClient, value);
    return result == null ? null : _fromRecord(key, result);
  }

  Future<K?> delete(DatabaseClient databaseClient, K key) async {
    final record = store.record(key);
    return record.delete(databaseClient);
  }

  Stream<List<T>> query(Database database, {Finder? finder}) {
    return store //
        .query(finder: finder)
        .onSnapshots(database)
        .map(_fromRecordSnapshots);
  }

  Future<List<T>> find(DatabaseClient databaseClient, {Finder? finder}) async {
    final records = await store.find(databaseClient, finder: finder);
    return _fromRecordSnapshots(records);
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
