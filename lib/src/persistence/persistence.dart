import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/utils/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';

part 'persistence.g.dart';

@service
Database database(Ref ref) {
  throw ProviderMustBeOverriddenException();
}
