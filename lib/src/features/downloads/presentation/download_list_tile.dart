import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/card.dart';

class DownloadListTile extends StatelessWidget {
  const DownloadListTile({
    super.key,
    required this.download,
    required this.onTap,
    required this.onDeletePressed,
  });

  final Download download;
  final VoidCallback onTap;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedCard(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: Insets.p8, top: Insets.p4),
          child: ListTile(
            minVerticalPadding: 0,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    download.filename,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            subtitle: Column(
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
                Gaps.p4,
                LinearProgressIndicator(
                  value: download.progress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
