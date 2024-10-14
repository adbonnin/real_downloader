import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/directory_watchers/application/directory_watcher_manager.dart';
import 'package:real_downloader/src/features/downloads/application/torrent_providers.dart';
import 'package:real_downloader/src/router/router.dart';
import 'package:real_downloader/src/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    const theme = AppTheme.light();

    return _EagerInitialization(
      child: MaterialApp.router(
        title: 'Real Downloader',
        theme: theme.build(),
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(directoryWatcherManagerProvider);
    ref.watch(torrentsNotifierProvider);
    return child;
  }
}
