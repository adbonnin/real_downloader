import 'package:flutter/material.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    super.key,
    this.icon,
    required this.error,
  });

  final Icon? icon;
  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconTheme(
          data: IconThemeData(color: theme.colorScheme.error),
          child: icon ?? const Icon(Icons.error),
        ),
        Gaps.p8,
        Flexible(
          child: Text(
            context.loc.translateError(error),
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
