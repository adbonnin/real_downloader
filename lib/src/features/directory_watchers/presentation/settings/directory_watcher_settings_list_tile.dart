import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';

class DirectoryWatcherSettingsListTile extends StatelessWidget {
  const DirectoryWatcherSettingsListTile(
    this.directoryWatcher, {
    this.onTap,
    this.onEnablePressed,
    this.onDeletePressed,
    super.key,
  });

  final DirectoryWatcher directoryWatcher;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onEnablePressed;
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      minVerticalPadding: 0,
      onTap: onTap,
      leading: Switch(
        value: directoryWatcher.enabled,
        onChanged: onEnablePressed,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              directoryWatcher.directory,
              maxLines: 1,
              style: TextStyle(
                color: directoryWatcher.enabled ? null : theme.disabledColor,
              ),
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
