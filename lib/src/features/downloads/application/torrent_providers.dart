import 'dart:async';

import 'package:real_downloader/src/features/account/application/account_providers.dart';
import 'package:real_downloader/src/features/downloads/application/use_cases/get_next_torrents_use_case.dart';
import 'package:real_downloader/src/utils/iterable.dart';
import 'package:realdebrid_api/realdebrid_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'torrent_providers.g.dart';

@Riverpod(keepAlive: true)
class TorrentsNotifier extends _$TorrentsNotifier {
  late RealDebridApi api;

  @override
  Future<List<TorrentItem>> build() async {
    api = ref.watch(realDebridApiProvider);

    final updateTorrentSubscription = Timer.periodic(const Duration(seconds: 10), (_) => _updateTorrents());
    ref.onDispose(updateTorrentSubscription.cancel);

    return GetNextTorrentsUseCase(api)();
  }

  Future<void> _updateTorrents() async {
    if (state.isLoading) {
      return;
    }

    final loadingState = const AsyncValue<List<TorrentItem>>.loading().copyWithPrevious(
      state,
      isRefresh: true,
    );

    state = loadingState;
    final nextState = await AsyncValue.guard(() => GetNextTorrentsUseCase(api)(state.valueOrNull));

    if (!identical(state, loadingState)) {
      return;
    }

    state = nextState;
  }

  Future<void> deleteTorrent(TorrentItem torrent) async {
    await api.torrents.deleteTorrent(id: torrent.id);

    final values = state.valueOrNull;

    if (values != null) {
      final nextValues = values.where((t) => t.id != torrent.id).toList();
      final nextState = AsyncData(nextValues);

      state = state.map(
        data: (d) => nextState,
        error: (e) => e.copyWithPrevious(nextState),
        loading: (l) => l.copyWithPrevious(nextState),
      );
    }
  }
}

extension TorrentsApiExtension on TorrentsApi {
  Future<List<TorrentItem>> getTorrentsUntil({
    int? limit = 10,
    bool activeFirst = false,
    required bool Function(TorrentItem) predicate,
  }) async {
    final result = <TorrentItem>[];

    for (var page = 1;; page++) {
      final List<TorrentItem> torrents;

      try {
        torrents = await getTorrents(
          page: page,
          limit: limit,
          activeFirst: activeFirst,
        );
      } //
      catch (e) {
        // return result;
        rethrow;
      }

      for (final torrent in torrents) {
        if (predicate(torrent)) {
          result.add(torrent);
        } //
        else {
          return result;
        }
      }

      if (torrents.length != limit) {
        return result;
      }
    }
  }

  Future<Iterable<TorrentItem>> getAllTorrents({
    int? limit = 10,
    bool activeFirst = false,
  }) async {
    final allTorrents = <List<TorrentItem>>[];

    for (var page = 1;; page++) {
      final List<TorrentItem> torrents;

      try {
        torrents = await getTorrents(
          page: page,
          limit: limit,
          activeFirst: activeFirst,
        );
      } //
      catch (e) {
        return allTorrents.flatten();
      }

      allTorrents.add(torrents);

      if (torrents.length != limit) {
        return allTorrents.flatten();
      }
    }
  }
}

extension TorrentListExtension on Iterable<TorrentItem> {
  Map<String, TorrentItem> mapById() {
    return map((e) => MapEntry(e.id, e)).toMap();
  }
}
