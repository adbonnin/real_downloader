import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:real_downloader/src/l10n/localizations.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      internalAnimations: false,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.dashboard_outlined),
          selectedIcon: const Icon(Icons.dashboard),
          label: context.loc.dashboard,
        ),
        NavigationDestination(
          icon: const Icon(Icons.download_outlined),
          selectedIcon: const Icon(Icons.download),
          label: context.loc.downloads,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: context.loc.settings,
        ),
      ],
      selectedIndex: navigationShell.currentIndex,
      onSelectedIndexChange: _onSelectedIndexChange,
      body: (_) => navigationShell,
    );
  }

  void _onSelectedIndexChange(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }
}
