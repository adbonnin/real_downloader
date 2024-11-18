import 'package:flutter/material.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/utils/form_field_validators.dart';
import 'package:real_downloader/src/widgets/file_picker.dart';

class DirectoryWatcherSettingsFormData {
  const DirectoryWatcherSettingsFormData({
    required this.directory,
  });

  final String directory;
}

class DirectoryWatcherSettingsForm extends StatefulWidget {
  const DirectoryWatcherSettingsForm({
    super.key,
    this.initialDirectory,
  });

  final String? initialDirectory;

  @override
  State<DirectoryWatcherSettingsForm> createState() => DirectoryWatcherSettingsFormState();
}

class DirectoryWatcherSettingsFormState extends State<DirectoryWatcherSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _directoryController;

  @override
  void initState() {
    super.initState();
    _directoryController = TextEditingController(text: widget.initialDirectory ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _directoryController,
            validator: FormFieldValidators.isNotBlankValidator(
              errorText: context.loc.directory_watcher_settings_emptyDirectoryError,
            ),
            decoration: InputDecoration(
              label: Text(context.loc.directory_watcher_settings_directoryLabel),
              suffixIcon: DirectoryPickerIconButton(
                controller: _directoryController,
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  DirectoryWatcherSettingsFormData value() {
    return DirectoryWatcherSettingsFormData(
      directory: _directoryController.text,
    );
  }
}
