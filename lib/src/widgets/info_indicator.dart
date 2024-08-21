import 'package:flutter/material.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/style.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    super.key,
    this.icon,
    required this.error,
  });

  final Widget? icon;
  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoIndicator(
      color: theme.colorScheme.error,
      icon: icon ?? const Icon(Icons.error),
      child: Text(context.loc.translateError(error)),
    );
  }
}

class InfoIndicator extends StatelessWidget {
  const InfoIndicator({
    super.key,
    this.color = Colors.blue,
    this.icon,
    required this.child,
  });

  final Color color;
  final Widget? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme(
          data: IconThemeData(color: color),
          child: icon ?? const Icon(Icons.info),
        ),
        Gaps.p8,
        Flexible(
          child: DefaultTextStyle.merge(
            style: TextStyle(color: color),
            child: child,
          ),
        ),
      ],
    );
  }
}
