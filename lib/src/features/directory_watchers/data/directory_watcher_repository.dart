import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/persistence/persistence.dart';
import 'package:real_downloader/src/utils/riverpod.dart';
import 'package:real_downloader/src/utils/sembast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';

part 'directory_watcher_repository.g.dart';

@service
DirectoryWatcherRepository directoryWatcherRepository(DirectoryWatcherRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  final store = DirectoryWatcherStore.store("directory_watcher");

  return DirectoryWatcherRepository(db, store);
}

class DirectoryWatcherRepository {
  const DirectoryWatcherRepository(this.db, this.store);

  final Database db;
  final DirectoryWatcherStore store;

  Future<String> generateKey() {
    return store.generateKey(db);
  }

  Stream<List<DirectoryWatcher>> query() {
    return store.query(db);
  }

  Future<String?> add(DirectoryWatcher dir) {
    return store.add(db, dir);
  }
}

class DirectoryWatcherStore extends StringMapStore<DirectoryWatcher> {
  const DirectoryWatcherStore(super.store);

  factory DirectoryWatcherStore.store(String name) {
    return DirectoryWatcherStore(stringMapStoreFactory.store(name));
  }

  @override
  DirectoryWatcher fromJson(Map<String, dynamic> json) {
    return DirectoryWatcher.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(DirectoryWatcher object) {
    return object.toJson();
  }
}
