import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../extensions/localization_ext.dart';
import '../../models/key_value_pair.dart';
import 'key_value_table_editor.dart';

class ParamsEditor extends StatelessWidget {
  final List<KeyValuePair> params;
  final ValueChanged<List<KeyValuePair>> onChanged;

  const ParamsEditor({
    super.key,
    required this.params,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return KeyValueTableEditor(
      entries: params,
      onChanged: onChanged,
      keyHeader: context.l10n.params_key_header,
      valueHeader: context.l10n.params_value_header,
      descHeader: context.l10n.params_desc_header,
    );
  }
}
