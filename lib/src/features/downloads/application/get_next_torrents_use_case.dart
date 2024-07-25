import 'package:real_downloader/src/features/downloads/application/torrent_providers.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

class GetNextTorrentsUseCase {
  const GetNextTorrentsUseCase(this.api);

  final RealDebridApi api;

  Future<List<TorrentItem>> call([List<TorrentItem>? prevTorrents]) async {
    if (prevTorrents == null) {
      final torrents = await api.torrents.getAllTorrents(
        activeFirst: true,
      );

      return torrents.toList();
    }

    final prevTorrentsById = prevTorrents.mapById();
    String? firstInactiveTorrentId;

    bool updatedTorrentPredicate(TorrentItem torrent) {
      final prevTorrent = prevTorrentsById[torrent.id];

      if (prevTorrent == torrent) {
        firstInactiveTorrentId = torrent.id;
        return false;
      }

      return true;
    }

    final updatedTorrents = await api.torrents.getTorrentsUntil(
      activeFirst: true,
      predicate: updatedTorrentPredicate,
    );

    if (firstInactiveTorrentId == null) {
      return updatedTorrents;
    }

    final firstInactiveTorrentIndex = prevTorrents.indexWhere((t) => t.id == firstInactiveTorrentId);

    if (firstInactiveTorrentIndex == 0) {
      return prevTorrents;
    }

    final updatedTorrentsIds = updatedTorrents.map((t) => t.id).toSet();

    return [
      ...updatedTorrents,
      ...prevTorrents //
          .sublist(firstInactiveTorrentIndex)
          .where((t) => !updatedTorrentsIds.contains(t.id)),
    ];
  }
}
