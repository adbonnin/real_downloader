import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/features/account/application/account_providers.dart';
import 'package:real_downloader/src/widgets/async_value_widget.dart';

class UserContainer extends ConsumerWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncUser = ref.watch(userProvider);

    return AsyncValueWidget(
      asyncUser,
      data: (_, user) => Text(
        user.username,
        style: theme.textTheme.headlineSmall,
      ),
      alignment: Alignment.centerLeft,
    );
  }
}
