import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:real_downloader/src/features/directory_watchers/data/directory_watcher_repository.dart';
import 'package:real_downloader/src/features/directory_watchers/model/directory_watcher.dart';
import 'package:real_downloader/src/features/directory_watchers/presentation/settings/directory_watcher_settings_form.dart';
import 'package:real_downloader/src/l10n/localizations.dart';

Future<DirectoryWatcher?> showDirectoryWatcherSettingsDialog({
  required BuildContext context,
  DirectoryWatcher? initialDirectoryWatcher,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  return showDialog<DirectoryWatcher>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    builder: (_) => DirectoryWatcherSettingsDialog(
      initialDirectoryWatcher: initialDirectoryWatcher,
    ),
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}

class DirectoryWatcherSettingsDialog extends ConsumerStatefulWidget {
  const DirectoryWatcherSettingsDialog({
    super.key,
    this.initialDirectoryWatcher,
  });

  final DirectoryWatcher? initialDirectoryWatcher;

  @override
  ConsumerState<DirectoryWatcherSettingsDialog> createState() => _DirectoryWatcherSettingsDialogState();
}

class _DirectoryWatcherSettingsDialogState extends ConsumerState<DirectoryWatcherSettingsDialog> {
  final _formKey = GlobalKey<DirectoryWatcherSettingsFormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.loc.directory_watcher_settings_title),
      content: DirectoryWatcherSettingsForm(
        key: _formKey,
        initialDirectory: widget.initialDirectoryWatcher?.directory,
      ),
      actions: [
        OutlinedButton(
          onPressed: _onCancelPressed,
          child: Text(context.loc.cancel),
        ),
        FilledButton(
          onPressed: _onValidatePressed,
          child: Text(
            widget.initialDirectoryWatcher == null
                ? context.loc.directory_watcher_settings_addFolderButton
                : context.loc.directory_watcher_settings_editFolderButton,
          ),
        )
      ],
    );
  }

  void _onCancelPressed() {
    context.pop();
  }

  Future<void> _onValidatePressed() async {
    final repository = ref.read(directoryWatcherRepositoryProvider);
    final formState = _formKey.currentState;

    if (formState == null || !formState.validate()) {
      return;
    }

    final value = formState.value();
    final id = widget.initialDirectoryWatcher?.id ?? (await repository.generateKey());

    final result = DirectoryWatcher(
      id: id,
      directory: value.directory,
    );

    if (mounted) {
      context.pop(result);
    }
  }
}
