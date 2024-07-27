import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/utils/bytes.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

abstract interface class Download {
  factory Download.torrent({
    required TorrentItem torrent,
  }) {
    return TorrentDownload(
      torrent: torrent,
    );
  }

  String get filename;

  int get bytes;

  int get totalBytes;

  double get progress;

  String statusText(AppLocalizations context);

  String informationText(AppLocalizations loc);
}

class TorrentDownload implements Download {
  const TorrentDownload({
    required this.torrent,
  });

  final TorrentItem torrent;

  @override
  String get filename {
    return torrent.filename;
  }

  @override
  int get bytes {
    return (totalBytes * progress).floor();
  }

  @override
  int get totalBytes {
    return torrent.bytes;
  }

  @override
  double get progress {
    return torrent.progress / 100;
  }

  @override
  String statusText(AppLocalizations loc) {
    return loc.translateTorrentStatus(torrent.status);
  }

  @override
  String informationText(AppLocalizations loc) {
    final bytesText = bytes.formatBytes();
    final totalBytesText = torrent.bytes.formatBytes();
    final progress = torrent.progress;

    return switch (torrent.status) {
      TorrentStatus.downloading => loc.downloading_text(bytesText, totalBytesText, progress),
      TorrentStatus.downloaded => loc.downloaded_text(totalBytesText, progress),
      _ => '',
    };
  }
}
