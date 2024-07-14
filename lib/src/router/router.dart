import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:real_downloader/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:real_downloader/src/features/downloads/presentation/downloads_screen.dart';
import 'package:real_downloader/src/router/shell_scaffold.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return AppRouter(ref).buildRouter();
}

class AppRouter {
  const AppRouter(this.ref);

  final Ref ref;

  GoRouter buildRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      routes: buildRoutes(),
    );
  }

  List<RouteBase> buildRoutes() {
    return [
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) => ShellScaffold(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (_, __) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/downloads',
                builder: (_, __) => const DownloadsScreen(),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
