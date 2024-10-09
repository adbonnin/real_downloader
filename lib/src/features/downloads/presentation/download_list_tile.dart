import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/card.dart';

class DownloadListTile extends StatefulWidget {
  const DownloadListTile({
    super.key,
    required this.download,
    required this.onTap,
    required this.delete,
  });

  final Download download;
  final VoidCallback onTap;
  final Future<void> Function() delete;

  @override
  State<DownloadListTile> createState() => _DownloadListTileState();
}

class _DownloadListTileState extends State<DownloadListTile> {
  var _deleting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedCard(
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: Insets.p8, top: Insets.p4),
          child: ListTile(
            minVerticalPadding: 0,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.download.filename,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  onPressed: _deleting ? null : _onDeletePressed,
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
                        widget.download.informationText(context.loc),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(widget.download.statusText(context.loc)),
                  ],
                ),
                Gaps.p4,
                LinearProgressIndicator(
                  value: widget.download.progress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onDeletePressed() async {
    if (_deleting) {
      return;
    }

    setState(() => _deleting = true);
    try {
      await widget.delete();
    }
    finally {
      if (mounted) {
        setState(() => _deleting = false);
      }
    }
  }
}
