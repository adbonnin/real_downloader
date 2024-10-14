import 'package:real_downloader/src/features/directory_watchers/application/directory_watcher_providers.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/utils/iterable.dart';
import 'package:real_downloader/src/utils/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'directory_watcher_manager.g.dart';

@service
DirectoryWatcherManager directoryWatcherManager(DirectoryWatcherManagerRef ref) {
  const manager = DirectoryWatcherManager();
  ref.listen(enabledDirectoryWatchersProvider, manager._handleUpdate, fireImmediately: true);

  return manager;
}

class DirectoryWatcherManager {
  const DirectoryWatcherManager();

  void add(DirectoryWatcher added) {
    print('added');
  }

  void delete(DirectoryWatcher directoryWatcher) {
    print('delete');
  }

  void update(DirectoryWatcher directoryWatcher) {
    print('update');
  }

  void _handleUpdate(AsyncValue<List<DirectoryWatcher>>? prev, AsyncValue<List<DirectoryWatcher>> next) {
    final prevValues = prev?.valueOrNull;
    final nextValues = next.valueOrNull;

    if (nextValues == null) {
      return;
    }

    if (prevValues == null) {
      for (final nextValue in nextValues) {
        add(nextValue);
      }

      return;
    }

    prevValues.difference(
      nextValues,
      (v) => v.id,
      onAdded: add,
      onRemoved: delete,
      onUpdated: (p, n) => update(n),
    );
  }
}
