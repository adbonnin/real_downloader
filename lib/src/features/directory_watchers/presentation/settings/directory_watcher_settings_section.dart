import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/directory_watchers/application/directory_watcher_providers.dart';
import 'package:real_downloader/src/features/directory_watchers/data/directory_watcher_repository.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_list.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/async_value_widget.dart';
import 'package:real_downloader/src/widgets/settings_section.dart';

class DirectoryWatcherSettingsSection extends ConsumerWidget {
  const DirectoryWatcherSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDirectoryWatchers = ref.watch(directoryWatchersProvider);

    return SettingsSection(
      title: Text(context.loc.directory_watcher_title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AsyncValueWidget(
            asyncDirectoryWatchers,
            data: (_, v) => DirectoryWatcherSettingsList(v),
          ),
          Gaps.p8,
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: () => _onAddPressed(ref),
              child: Text(context.loc.directory_watcher_addButton),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onAddPressed(WidgetRef ref) async {
    final repo = ref.read(directoryWatcherRepositoryProvider);

    final key = await repo.generateKey();
    repo.add(DirectoryWatcher(id: key, directory: key));
  }
}
