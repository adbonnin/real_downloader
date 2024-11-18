import 'package:riverpod_annotation/riverpod_annotation.dart';

const service = Riverpod(keepAlive: true);

Provider<T> mustBeOverriddenProvider<T>() {
  return Provider<T>((_) => throw ProviderMustBeOverriddenException());
}

class ProviderMustBeOverriddenException extends UnimplementedError {
  ProviderMustBeOverriddenException() : super('Provider must be overridden in the container initialization');
}
