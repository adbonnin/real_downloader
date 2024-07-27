import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/features/downloads/presentation/download_list_tile.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

class DownloadListView extends StatelessWidget {
  const DownloadListView({
    super.key,
    required this.torrents,
  });

  final List<TorrentItem> torrents;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: _buildItem,
      separatorBuilder: (_, __) => const Divider(),
      itemCount: torrents.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final torrent = torrents[index];

    return DownloadListTile(
      download: Download.torrent(
        torrent: torrent,
      ),
    );
  }
}
