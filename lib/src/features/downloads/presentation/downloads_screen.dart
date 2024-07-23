import 'package:flutter/material.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/router/base_scaffold.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Text(context.loc.downloads),
      ),
    );
  }
}
