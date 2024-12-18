import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/directory_watchers/data/directory_watcher_repository.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/utils/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'directory_watcher_providers.g.dart';

@service
Stream<List<DirectoryWatcher>> directoryWatchers(Ref ref) {
  return ref.watch(directoryWatcherRepositoryProvider).query();
}

@service
Stream<List<DirectoryWatcher>> enabledDirectoryWatchers(Ref ref) {
  return ref.watch(directoryWatcherRepositoryProvider).queryEnabled();
}