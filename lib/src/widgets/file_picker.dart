import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:real_downloader/src/utils/file.dart';
import 'package:real_downloader/src/utils/string.dart';

class DirectoryPickerIconButton extends StatefulWidget {
  const DirectoryPickerIconButton({
    super.key,
    this.dialogTitle,
    this.lockParentWindow = false,
    required this.controller,
  });

  final String? dialogTitle;
  final bool lockParentWindow;
  final TextEditingController controller;

  @override
  State<DirectoryPickerIconButton> createState() => _DirectoryPickerIconButtonState();
}

class _DirectoryPickerIconButtonState extends State<DirectoryPickerIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPickFile,
      icon: const Icon(Icons.folder_open),
    );
  }

  Future<void> _onPickFile() async {
    var path = widget.controller.text.blankToNull;
    var dir = path == null ? null : (await Directory(path).findExists());

    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: widget.dialogTitle,
      lockParentWindow: widget.lockParentWindow,
      initialDirectory: dir?.path,
    );

    if (result == null) {
      return;
    }

    if (mounted) {
      widget.controller.text = result;
    }
  }
}
