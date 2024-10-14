import 'dart:io';

extension DirectoryExtension on Directory {
  Future<Directory?> findExists() async {
    var dir = this;

    for (;;) {
      if (await dir.exists()) {
        return dir;
      }

      final nextParent = dir.parent;

      if (nextParent == dir || nextParent.path == '.') {
        return null;
      }

      dir = nextParent;
    }
  }
}
