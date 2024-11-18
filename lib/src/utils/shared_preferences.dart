import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences prefs(Ref ref) {
  throw UnimplementedError();
}

NotifierProvider<PrefNotifier<T>, T> createPrefProvider<T>({
  required String key,
  required T defaultValue,
}) {
  return NotifierProvider(
    () => PrefNotifier(
      key: key,
      defaultValue: defaultValue,
    ),
  );
}

class PrefNotifier<T> extends Notifier<T> {
  PrefNotifier({
    required this.key,
    required this.defaultValue,
  });

  final String key;
  final T defaultValue;

  late SharedPreferences _prefs;

  @override
  T build() {
    _prefs = ref.watch(prefsProvider);
    return _prefs.getOrDefault(key, defaultValue);
  }

  Future<void> update(T value) async {
    switch (value) {
      case bool _:
        await _prefs.setBool(key, value);
      case int _:
        await _prefs.setInt(key, value);
      case double _:
        await _prefs.setDouble(key, value);
      case String _:
        await _prefs.setString(key, value);
      case List<String> _:
        await _prefs.setStringList(key, value);
    }

    state = value;
  }
}

extension SharedPreferencesExtension on SharedPreferences {
  T getOrDefault<T>(String key, T defaultValue) {
    return get(key) as T? ?? defaultValue;
  }
}
