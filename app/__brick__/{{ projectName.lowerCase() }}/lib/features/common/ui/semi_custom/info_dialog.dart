import 'package:flutter/material.dart';
import 'package:{{ projectName.snakeCase() }}/app/app_strings.al.dart';

import '../generic/generic_info_dialog.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    super.key,
    required this.msg,
    this.onPressed,
  });

  final String msg;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GenericInfoDialog(
      msg: msg,
      btnLabel: Strings.genericOk.get(),
      onPressed: onPressed,
      isPlatformSpecific: true,
    );
  }
}
