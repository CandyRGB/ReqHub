import 'package:flutter/material.dart';

/// Borderless inline text field used for renaming items in the tree.
class InlineEditField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSubmit;

  const InlineEditField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      color: cs.surface,
      child: EditableText(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        style: TextStyle(fontSize: 12, color: cs.onSurface),
        cursorColor: cs.onSurface,
        selectionColor: cs.primary.withValues(alpha: 0.25),
        backgroundCursorColor: cs.onSurfaceVariant,
        onSubmitted: (_) => onSubmit(),
      ),
    );
  }
}
