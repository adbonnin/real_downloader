import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/directory_watchers/application/directory_watcher_providers.dart';
import 'package:real_downloader/src/features/directory_watchers/data/directory_watcher_repository.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_dialog.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_list.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/async_value_widget.dart';
import 'package:real_downloader/src/widgets/settings_section.dart';

class DirectoryWatcherSettingsSection extends ConsumerStatefulWidget {
  const DirectoryWatcherSettingsSection({super.key});

  @override
  ConsumerState<DirectoryWatcherSettingsSection> createState() => _DirectoryWatcherSettingsSectionState();
}

class _DirectoryWatcherSettingsSectionState extends ConsumerState<DirectoryWatcherSettingsSection> {
  @override
  Widget build(BuildContext context) {
    final asyncDirectoryWatchers = ref.watch(directoryWatchersProvider);

    return SettingsSection(
      title: Text(context.loc.directory_watcher_title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AsyncValueWidget(
            asyncDirectoryWatchers,
            data: (_, directoryWatchers) => DirectoryWatcherSettingsList(
              directoryWatchers,
              onValueTap: _onValueTap,
              onValueChanged: _onValueChanged,
              onValueDeleted: _onValueDeleted,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Insets.p18, Insets.p8, Insets.p18, Insets.p12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: _onAddPressed,
                child: Text(context.loc.directory_watcher_addButton),
              ),
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Future<void> _onAddPressed() async {
    _editDirectory();
  }

  void _onValueTap(DirectoryWatcher value) {
    _editDirectory(value);
  }

  Future<void> _editDirectory([DirectoryWatcher? value]) async {
    final repo = ref.read(directoryWatcherRepositoryProvider);

    final result = await showDirectoryWatcherSettingsDialog(
      context: context,
      initialDirectoryWatcher: value,
    );

    if (result == null) {
      return;
    }

    repo.update(result);
  }

  void _onValueChanged(DirectoryWatcher value) {
    final repo = ref.read(directoryWatcherRepositoryProvider);

    repo.update(value);
  }

  void _onValueDeleted(DirectoryWatcher value) {
    final repo = ref.read(directoryWatcherRepositoryProvider);

    repo.deleteByKey(value.id);
  }
}
