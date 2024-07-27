import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';

class DownloadListTile extends StatelessWidget {
  const DownloadListTile({
    super.key,
    required this.download,
  });

  final Download download;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: const Icon(
        Icons.description_outlined,
        size: IconSizes.p48,
      ),
      title: Text(
        download.filename,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    download.informationText(context.loc),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(download.statusText(context.loc)),
              ],
            ),
            Gaps.p8,
            LinearProgressIndicator(
              value: download.progress,
            ),
          ],
        ),
      ),
    );
  }
}
