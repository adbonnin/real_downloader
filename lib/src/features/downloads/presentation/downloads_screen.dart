import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/downloads/application/torrent_providers.dart';
import 'package:real_downloader/src/features/downloads/presentation/download_list_view.dart';
import 'package:real_downloader/src/router/base_scaffold.dart';
import 'package:real_downloader/src/widgets/async_value_widget.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTorrents = ref.watch(torrentsNotifierProvider);

    return BaseScaffold(
      body: AsyncValueWidget(
        asyncTorrents,
        data: (_, torrents) => DownloadListView(
          torrents: torrents,
          delete: (torrent) => _deleteTorrent(ref, torrent),
        ),
      ),
    );
  }

  Future<void> _deleteTorrent(WidgetRef ref, TorrentItem torrent) async {
    await ref.read(torrentsNotifierProvider.notifier).deleteTorrent(torrent);
  }
}
