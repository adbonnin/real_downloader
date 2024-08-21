import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';

class DownloadListTile extends StatefulWidget {
  const DownloadListTile({
    super.key,
    required this.download,
    required this.onDeletePressed,
  });

  final Download download;
  final VoidCallback onDeletePressed;

  @override
  State<DownloadListTile> createState() => _DownloadListTileState();
}

class _DownloadListTileState extends State<DownloadListTile> {
  var _isHover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onHover: _onHover,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Insets.p4),
        child: ListTile(
          title: Text(
            widget.download.filename,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
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
              Gaps.p8,
              LinearProgressIndicator(
                value: widget.download.progress,
              ),
            ],
          ),
          trailing: !_isHover
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: widget.onDeletePressed,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _onHover(bool value) {
    setState(() {
      _isHover = value;
    });
  }
}
