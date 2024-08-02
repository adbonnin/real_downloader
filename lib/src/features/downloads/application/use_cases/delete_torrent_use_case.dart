import 'package:realdebrid_api/realdebrid_api.dart';

class DeleteTorrentUseCase {
  const DeleteTorrentUseCase(this.api);

  final RealDebridApi api;

  Future<void> call(String id) {
    return api.torrents.deleteTorrent(id: id);
  }
}