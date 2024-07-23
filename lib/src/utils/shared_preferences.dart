import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences prefs(PrefsRef ref) {
  throw UnimplementedError();
}

StateNotifierProvider<SharedPreferenceNotifier<T>, T> createPref<T>({
  required String key,
  required T defaultValue,
}) {
  return StateNotifierProvider(
    (ref) => SharedPreferenceNotifier(
      prefs: ref.watch(prefsProvider),
      key: key,
      defaultValue: defaultValue,
    ),
  );
}

class SharedPreferenceNotifier<T> extends StateNotifier<T> {
  SharedPreferenceNotifier({
    required this.prefs,
    required this.key,
    required T defaultValue,
  }) : super(prefs.getOrDefault(key, defaultValue));

  final SharedPreferences prefs;
  final String key;

  Future<void> update(T value) async {
    switch (value) {
      case bool _:
        prefs.setBool(key, value);
      case int _:
        prefs.setInt(key, value);
      case double _:
        prefs.setDouble(key, value);
      case String _:
        prefs.setString(key, value);
      case List<String> _:
        prefs.setStringList(key, value);
    }

    state = value;
  }
}

extension SharedPreferencesExtension on SharedPreferences {
  T getOrDefault<T>(String key, T defaultValue) {
    return get(key) as T? ?? defaultValue;
  }
}
