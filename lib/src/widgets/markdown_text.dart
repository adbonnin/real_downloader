import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownText extends StatelessWidget {
  const MarkdownText(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,
      onTapLink: _onTapLink,
    );
  }

  void _onTapLink(String text, String? href, String title) {
    if (href == null) {
      return;
    }

    final url = Uri.tryParse(href);

    if (url == null) {
      return;
    }

    launchUrl(url);
  }
}
