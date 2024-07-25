import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:real_downloader/src/features/account/application/account_providers.dart';
import 'package:realdebrid_api/realdebrid_api.dart';

extension BuildContextLocalizationExtension on BuildContext {
  AppLocalizations get loc {
    return AppLocalizations.of(this);
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  String translateError(Object error) {
    if (error is ApiException) {
      if (error.error == 'bad_token') {
        return error_realDebrid_badToken;
      }

      return error_realDebrid_apiException;
    }

    if (error is RealDebridAuthenticationException) {
      return error_realDebrid_apiException;
    }

    return error.toString();
  }
}
