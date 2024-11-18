import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/utils/shared_preferences.dart';
import 'package:realdebrid_api/realdebrid_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'account_providers.g.dart';

final tokenPreferenceProvider = createPrefProvider<String?>(
  key: "real_debrid_api_token",
  defaultValue: null,
);

@Riverpod(keepAlive: true)
class ApiClientNotifier extends _$ApiClientNotifier {
  late http.Client _httpClient;

  @override
  ApiClient build() {
    final apiToken = ref.watch(tokenPreferenceProvider);

    if (apiToken == null) {
      throw EmptyTokenException();
    }

    _httpClient = http.Client();
    ref.onDispose(_httpClient.close);

    final client = BaseApiClient.basicAuthentication(
      apiToken: apiToken,
      client: _httpClient
    );

    return ProxyApiClient(
      client: client,
      onError: _onError,
    );
  }

  void _onError(Object error, StackTrace stackTrace) {}
}

@Riverpod(keepAlive: true)
RealDebridApi realDebridApi(Ref ref) {
  final client = ref.watch(apiClientNotifierProvider);
  return RealDebridApi(client);
}

@riverpod
Future<User> user(Ref ref) {
  final api = ref.watch(realDebridApiProvider);
  return api.user.getUser();
}

class AuthenticationException implements Exception {}

class EmptyTokenException implements AuthenticationException {}

class ProxyApiClient implements ApiClient {
  ProxyApiClient({
    required this.client,
    required this.onError,
  });

  final ApiClient client;
  final void Function(Object error, StackTrace stacktrace) onError;

  @override
  Future<T> send<T>(
    String method,
    String pathTemplate, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Map<String, String>? fieldParameters,
    Map<String, String>? headers,
    dynamic body,
  }) {
    try {
      return client.send(
        method,
        pathTemplate,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        fieldParameters: fieldParameters,
        headers: headers,
        body: body,
      );
    } //
    catch (error, stackTrace) {
      onError(error, stackTrace);
      rethrow;
    }
  }

  @override
  void close() {
    client.close();
  }
}
