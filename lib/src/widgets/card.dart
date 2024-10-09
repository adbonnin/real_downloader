import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      elevation: 0,
      child: child,
    );
  }
}
