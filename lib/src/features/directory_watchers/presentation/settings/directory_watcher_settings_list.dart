import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_list_tile.dart';

class DirectoryWatcherSettingsList extends StatelessWidget {
  const DirectoryWatcherSettingsList(
    this.directoryWatchers, {
    super.key,
  });

  final List<DirectoryWatcher> directoryWatchers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final directoryWatcher in directoryWatchers) //
          DirectoryWatcherSettingsListTile(directoryWatcher),
      ],
    );
  }
}
