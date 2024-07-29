import 'package:flutter/material.dart';
import 'package:real_downloader/src/style.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    this.titleText,
    required this.child,
  });

  final String? titleText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (titleText != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(titleText!),
          ),
          const SizedBox(height: 10),
        ],
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.p18, vertical: Insets.p12),
            child: child,
          ),
        )
      ],
    );
  }
}
