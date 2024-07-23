import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/settings/presentation/account_settings/account_settings_card.dart';
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
                Gaps.p22,
                AccountSettingsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
