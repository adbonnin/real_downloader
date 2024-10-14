import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_list_tile.dart';

class DirectoryWatcherSettingsList extends StatelessWidget {
  const DirectoryWatcherSettingsList(
    this.directoryWatchers, {
    super.key,
    required this.onValueTap,
    required this.onValueChanged,
    required this.onValueDeleted,
  });

  final List<DirectoryWatcher> directoryWatchers;
  final ValueChanged<DirectoryWatcher> onValueTap;
  final ValueChanged<DirectoryWatcher> onValueChanged;
  final ValueChanged<DirectoryWatcher> onValueDeleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final directoryWatcher in directoryWatchers) //
          _buildTile(directoryWatcher),
      ],
    );
  }

  Widget _buildTile(DirectoryWatcher directoryWatcher) {
    void onEnabledPressed(bool enabled) {
      final updated = directoryWatcher.copyWith(
        enabled: enabled,
      );

      onValueChanged(updated);
    }

    return DirectoryWatcherSettingsListTile(
      key: Key(directoryWatcher.id),
      directoryWatcher,
      onTap: () => onValueTap(directoryWatcher),
      onEnablePressed: onEnabledPressed,
      onDeletePressed: () => onValueDeleted(directoryWatcher),
    );
  }
}
