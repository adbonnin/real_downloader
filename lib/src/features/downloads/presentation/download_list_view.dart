import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/features/downloads/presentation/download_list_tile.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

class DownloadListView extends StatelessWidget {
  const DownloadListView({
    super.key,
    required this.torrents,
    required this.onDeletePressed,
  });

  final List<TorrentItem> torrents;
  final void Function(TorrentItem) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: _buildItem,
      separatorBuilder: (_, __) => const Divider(height: 2, thickness: 2),
      itemCount: torrents.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final torrent = torrents[index];

    return DownloadListTile(
      download: Download.torrent(torrent: torrent),
      onDeletePressed: () => onDeletePressed(torrent),
    );
  }
}
