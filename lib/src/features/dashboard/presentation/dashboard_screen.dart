import 'package:flutter/material.dart';
import 'package:real_downloader/src/router/base_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
