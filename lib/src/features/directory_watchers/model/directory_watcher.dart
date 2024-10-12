import 'package:json_annotation/json_annotation.dart';

part 'directory_watcher.g.dart';

@JsonSerializable()
class DirectoryWatcher {
  const DirectoryWatcher({
    required this.id,
    this.enabled = true,
    required this.directory,
    this.pollingDelay,
  });

  final String id;

  final bool enabled;

  final String directory;

  final Duration? pollingDelay;

  factory DirectoryWatcher.fromJson(Map<String, dynamic> json) => //
      _$DirectoryWatcherFromJson(json);

  Map<String, dynamic> toJson() => //
      _$DirectoryWatcherToJson(this);
}
