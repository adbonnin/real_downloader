import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:real_downloader/src/features/account/application/account_providers.dart';
import 'package:real_downloader/src/features/settings/presentation/account_settings/account_settings_form.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/loading_overlay.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

void showAccountSettingsDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    builder: (_) => const AccountSettingsDialog(),
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}

class AccountSettingsDialog extends ConsumerStatefulWidget {
  const AccountSettingsDialog({super.key});

  @override
  ConsumerState<AccountSettingsDialog> createState() => _AccountSettingsDialogState();
}

class _AccountSettingsDialogState extends ConsumerState<AccountSettingsDialog> {
  final _formKey = GlobalKey<AccountSettingsFormState>();
  final _loadingKey = GlobalKey<LoadingContainerState>();

  var _isAuthenticating = false;

  @override
  Widget build(BuildContext context) {
    final apiToken = ref.watch(tokenPreferenceProvider);

    return AlertDialog(
      title: Text(context.loc.account),
      content: ConstrainedBox(
        constraints: DialogConstraints.dialog,
        child: LoadingContainer(
          key: _loadingKey,
          isLoading: _isAuthenticating,
          child: AccountSettingsForm(
            key: _formKey,
            initialApiToken: apiToken,
            onChanged: _onFormChanged,
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: _onCancelPressed,
          child: Text(context.loc.cancel),
        ),
        FilledButton(
          onPressed: _isAuthenticating ? null : _onAuthenticatePressed,
          child: Text(context.loc.signIn),
        ),
      ],
    );
  }

  void _onCancelPressed() {
    context.pop();
  }

  void _onFormChanged() {
    _loadingKey.currentState?.resetError();
  }

  Future<void> _onAuthenticatePressed() async {
    final tokenPreference = ref.read(tokenPreferenceProvider.notifier);
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    final apiToken = form.value();
    final client = RealDebridApiClient.basicAuthentication(apiToken: apiToken);
    final api = RealDebridApi(client);

    try {
      setState(() {
        _isAuthenticating = true;
      });

      await api.user.getUser();
    } //
    catch (e) {
      if (mounted) {
        _loadingKey.currentState?.setError(e);
      }

      return;
    } //
    finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }

    if (!mounted) {
      return;
    }

    tokenPreference.update(apiToken);
    context.pop();
  }
}
