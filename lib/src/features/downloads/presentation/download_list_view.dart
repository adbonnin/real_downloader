import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/features/downloads/presentation/download_list_tile.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/info_indicator.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

class DownloadListView<T extends TorrentItem> extends StatelessWidget {
  const DownloadListView({
    super.key,
    required this.torrents,
    required this.delete,
  });

  final List<T> torrents;
  final Future<void> Function(T) delete;

  @override
  Widget build(BuildContext context) {
    if (torrents.isEmpty) {
      return Center(
        child: InfoIndicator(
          child: Text(context.loc.downloads_empty),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: _buildItem,
      separatorBuilder: (_, __) => Gaps.p2,
      itemCount: torrents.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final torrent = torrents[index];

    return DownloadListTile(
      download: Download.torrent(torrent: torrent),
      onTap: () {},
      delete: () => delete(torrent),
    );
  }
}
