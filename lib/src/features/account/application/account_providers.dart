import 'dart:async';

import 'package:real_downloader/src/utils/shared_preferences.dart';
import 'package:realdebrid_api/realdebrid_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_providers.g.dart';

final tokenPreferenceProvider = createPref<String?>(
  key: "real_debrid_api_token",
  defaultValue: null,
);

@Riverpod(keepAlive: true)
RealDebridApi? realDebridApi(RealDebridApiRef ref) {
  final apiToken = ref.watch(tokenPreferenceProvider);

  if (apiToken == null) {
    return null;
  }

  final client = ApiClient.basicAuthentication(apiToken: apiToken);
  return RealDebridApi(client);
}

@Riverpod(keepAlive: true)
Future<User?> user(UserRef ref) async {
  final api = ref.watch(realDebridApiProvider);

  if (api == null) {
    return null;
  }

  return api.user.getUser();
}
