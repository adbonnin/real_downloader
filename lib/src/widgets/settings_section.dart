import 'package:flutter/material.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/card.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: Insets.p18, vertical: Insets.p12),
    this.title,
    required this.content,
  });

  final EdgeInsets contentPadding;
  final Widget? title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: title,
          ),
          const SizedBox(height: 10),
        ],
        OutlinedCard(
          child: Padding(
            padding: contentPadding,
            child: content,
          ),
        )
      ],
    );
  }
}
