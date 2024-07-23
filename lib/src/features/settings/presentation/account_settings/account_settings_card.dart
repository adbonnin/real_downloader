import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/account/presentation/user_container.dart';
import 'package:real_downloader/src/features/settings/presentation/account_settings/account_settings_dialog.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/settings_section.dart';

class AccountSettingsCard extends ConsumerWidget {
  const AccountSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSection(
      titleText: context.loc.account,
      child: Row(
        children: [
          const Expanded(
            child: UserContainer(),
          ),
          Gaps.p12,
          OutlinedButton(
            onPressed: () => _onModifyPressed(context),
            child: Text(context.loc.modify),
          ),
        ],
      ),
    );
  }

  void _onModifyPressed(BuildContext context) {
    showAccountSettingsDialog(context: context);
  }
}
