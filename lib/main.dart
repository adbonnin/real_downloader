import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:real_downloader/src/app.dart';
import 'package:real_downloader/src/persistence/persistence.dart';
import 'package:real_downloader/src/utils/shared_preferences.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();
  await dir.create(recursive: true);

  final dbPath = join(dir.path, 'sembast.db');
  final db = await databaseFactoryIo.openDatabase(dbPath);

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
      ],
      child: const MyApp(),
    ),
  );
}
