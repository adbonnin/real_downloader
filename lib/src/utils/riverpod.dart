import 'package:riverpod_annotation/riverpod_annotation.dart';

const service = Riverpod(keepAlive: true);

Provider<T> mustOverrideProvider<T>() {
  return Provider<T>((_) => throw ProviderNotOverriddenException());
}

class ProviderNotOverriddenException implements Exception {
  @override
  String toString() {
    return 'The value for this provider must be set by an override on ProviderScope at runtime, '
        'usually when the application is first started.';
  }
}
