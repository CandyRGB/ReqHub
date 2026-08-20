import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../extensions/localization_ext.dart';
import '../../models/key_value_pair.dart';
import 'key_value_table_editor.dart';

class HeadersEditor extends StatelessWidget {
  final List<KeyValuePair> headers;
  final ValueChanged<List<KeyValuePair>> onChanged;

  const HeadersEditor({
    super.key,
    required this.headers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return KeyValueTableEditor(
      entries: headers,
      onChanged: onChanged,
      keyHeader: context.l10n.headers_key_header,
      valueHeader: context.l10n.headers_value_header,
      descHeader: context.l10n.headers_desc_header,
    );
  }
}
