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

  Stream<List<T>> query(Database database, {Finder? finder}) {
    return store //
        .query(finder: finder)
        .onSnapshots(database)
        .map(_fromRecords);
  }

  Future<List<T>> find(DatabaseClient databaseClient, {Finder? finder}) async {
    final records = await store.find(databaseClient, finder: finder);
    return _fromRecords(records);
  }

  List<T> _fromRecords(Iterable<RecordSnapshot<K, Map<String, dynamic>>> records) {
    return records.map(_fromRecord).toList(growable: false);
  }

  T _fromRecord(RecordSnapshot<K, Map<String, dynamic>> record) {
    return fromJson({'id': record.key, ...record.value});
  }
}
