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

  DirectoryWatcher copyWith({
    String? id,
    bool? enabled,
    String? directory,
    Duration? pollingDelay,
  }) {
    return DirectoryWatcher(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      directory: directory ?? this.directory,
      pollingDelay: pollingDelay ?? this.pollingDelay,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is DirectoryWatcher && //
        other.id == id &&
        other.enabled == enabled &&
        other.directory == directory &&
        other.pollingDelay == pollingDelay;
  }

  @override
  int get hashCode {
    return id.hashCode ^ //
        enabled.hashCode ^
        directory.hashCode ^
        pollingDelay.hashCode;
  }
}
