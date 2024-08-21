import 'package:realdebrid_api/realdebrid_api.dart';

class CachedExceptionApiClient implements ApiClient {
  CachedExceptionApiClient(this.innerClient);

  final ApiClient innerClient;
  dynamic cachedException;

  @override
  Future<T> send<T>(
    String method,
    String pathTemplate, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Map<String, String>? fieldParameters,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    if (cachedException != null) {
      throw cachedException;
    }

    try {
      final response = await innerClient.send(
        method,
        pathTemplate,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        fieldParameters: fieldParameters,
        headers: headers,
        body: body,
      );

      return response;
    } //
    catch (e) {
      if (e is ApiException && e.statusCode == 401) {
        cachedException = e;
      }

      rethrow;
    }
  }

  @override
  void close() {
    innerClient.close();
  }
}
