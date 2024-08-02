import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/account/application/account_providers.dart';
import 'package:real_downloader/src/features/downloads/application/torrent_providers.dart';
import 'package:real_downloader/src/features/downloads/application/use_cases/delete_torrent_use_case.dart';
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
        value: asyncTorrents,
        data: (_, torrents) => DownloadListView(
          torrents: torrents,
          onDeletePressed: (torrent) => _onDeletePressed(ref, torrent),
        ),
      ),
    );
  }

  Future<void> _onDeletePressed(WidgetRef ref, TorrentItem torrent) {
    final api = ref.read(realDebridApiProvider);
    return DeleteTorrentUseCase(api).call(torrent.id);
  }
}
