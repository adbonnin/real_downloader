import 'package:flutter/material.dart';
import 'package:real_downloader/src/l10n/localizations.dart';
import 'package:real_downloader/src/utils/form_field_validators.dart';
import 'package:real_downloader/src/widgets/markdown_text.dart';

class AccountSettingsForm extends StatefulWidget {
  const AccountSettingsForm({
    super.key,
    this.initialApiToken,
    this.onChanged,
  });

  final String? initialApiToken;
  final VoidCallback? onChanged;

  @override
  State<AccountSettingsForm> createState() => AccountSettingsFormState();
}

class AccountSettingsFormState extends State<AccountSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _apiTokenController;

  @override
  void initState() {
    super.initState();
    _apiTokenController = TextEditingController(text: widget.initialApiToken ?? '');
  }

  @override
  void dispose() {
    _apiTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: widget.onChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: context.loc.apiPrivateToken,
            ),
            validator: FormFieldValidators.isNotBlankValidator(
              errorText: context.loc.error_isNotBlank,
            ),
            controller: _apiTokenController,
          ),
          MarkdownText(context.loc.apiPrivateTokenInfo("https://real-debrid.com/apitoken")),
        ],
      ),
    );
  }

  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  String value() {
    return _apiTokenController.text.trim();
  }
}
