import 'package:flutter/material.dart';
import 'package:real_downloader/src/features/downloads/domain/download.dart';
import 'package:real_downloader/src/style.dart';

class DownloadCard extends StatelessWidget {
  const DownloadCard({
    super.key,
    required this.download,
  });

  final Download download;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Insets.p16),
        child: Text(download.filename),
      ),
    );
  }
}
