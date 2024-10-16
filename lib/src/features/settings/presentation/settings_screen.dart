import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/account/presentation/settings/account_settings_section.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_section.dart';
import 'package:real_downloader/src/router/base_scaffold.dart';
import 'package:real_downloader/src/style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gaps.p24,
                AccountSettingsSection(),
                Gaps.p24,
                DirectoryWatcherSettingsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
