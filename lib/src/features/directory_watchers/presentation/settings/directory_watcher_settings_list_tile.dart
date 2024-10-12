import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';

class DirectoryWatcherSettingsListTile extends StatelessWidget {
  const DirectoryWatcherSettingsListTile(
    this.directoryWatcher, {
    super.key,
  });

  final DirectoryWatcher directoryWatcher;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(directoryWatcher.directory),
    );
  }
}
