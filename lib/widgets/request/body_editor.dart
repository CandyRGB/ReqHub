import 'package:flutter/material.dart' hide FormField;
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:highlight/languages/json.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:path/path.dart' as path;

import '../../extensions/localization_ext.dart';
import '../../models/request_body.dart';
import '../../models/key_value_pair.dart';
import 'key_value_table_editor.dart';

class BodyEditor extends StatefulWidget {
  final RequestBody body;
  final ValueChanged<RequestBody> onChanged;

  const BodyEditor({super.key, required this.body, required this.onChanged});

  @override
  State<BodyEditor> createState() => _BodyEditorState();
}

class _BodyEditorState extends State<BodyEditor> {
  late String _bodyType;
  late CodeController? _rawCtrl;

  @override
  void initState() {
    super.initState();
    _bodyType = _typeOf(widget.body);
    _initCtrl();
  }

  @override
  void didUpdateWidget(covariant BodyEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newType = _typeOf(widget.body);
    if (newType != _bodyType ||
        ((newType == 'json' || newType == 'raw') && _rawCtrl == null)) {
      _rawCtrl?.dispose();
      _bodyType = newType;
      _initCtrl();
    } else {
      final content = _rawContent(widget.body);
      final oldContent = _rawContent(oldWidget.body);
      if (content != oldContent && content != _rawCtrl?.text) {
        _rawCtrl?.text = content;
      }
    }
  }

  @override
  void dispose() {
    _rawCtrl?.dispose();
    super.dispose();
  }

  String _typeOf(RequestBody b) => switch (b) {
    NoneBody() => 'none',
    JsonBody() => 'json',
    FormDataBody() => 'form-data',
    UrlEncodedBody() => 'x-www-form-urlencoded',
    RawBody() => 'raw',
    BinaryBody() => 'binary',
  };

  String _rawContent(RequestBody b) => switch (b) {
    JsonBody(raw: final r) => r,
    RawBody(content: final c) => c,
    _ => '',
  };

  void _initCtrl() {
    final content = _rawContent(widget.body);
    if (_bodyType == 'json' || _bodyType == 'raw') {
      _rawCtrl = CodeController(
        text: content,
        language: _bodyType == 'json' ? json : null,
      );
    } else {
      _rawCtrl = null;
    }
  }

  void _setBodyType(String type) {
    _rawCtrl?.dispose();
    _rawCtrl = null;
    setState(() => _bodyType = type);
    // Notify parent; didUpdateWidget will call _initCtrl once the parent
    // rebuilds with the new value.
    switch (type) {
      case 'none':
        widget.onChanged(const RequestBody.none());
      case 'json':
        widget.onChanged(const RequestBody.json());
      case 'form-data':
        widget.onChanged(const RequestBody.formData());
      case 'x-www-form-urlencoded':
        widget.onChanged(const RequestBody.urlEncoded());
      case 'raw':
        widget.onChanged(const RequestBody.raw());
      case 'binary':
        widget.onChanged(const RequestBody.binary());
    }
  }

  Future<void> _pickBinaryFile() async {
    final file = await openFile();
    if (file == null || !mounted) return;
    widget.onChanged(RequestBody.binary(filePath: file.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Text(
                context.l10n.body_type_label,
                style: const TextStyle(fontSize: 13),
              ),
              const Spacer(),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'none',
                    label: Text('none', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'json',
                    label: Text('json', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'form-data',
                    label: Text('form', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'x-www-form-urlencoded',
                    label: Text('urlenc', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'raw',
                    label: Text('raw', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'binary',
                    label: Text('bin', style: TextStyle(fontSize: 12)),
                  ),
                ],
                selected: {_bodyType},
                onSelectionChanged: (v) => _setBodyType(v.first),
                showSelectedIcon: false,
                emptySelectionAllowed: false,
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _buildBodyEditor()),
      ],
    );
  }

  Widget _buildBodyEditor() {
    if (_typeOf(widget.body) != _bodyType) {
      return const SizedBox.shrink(); // waiting for parent to rebuild
    }
    switch (_bodyType) {
      case 'json':
      case 'raw':
        if (_rawCtrl == null) return const SizedBox.shrink();
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Material(
          type: MaterialType.transparency,
          child: CodeTheme(
            data: CodeThemeData(
              styles: isDark ? atomOneDarkTheme : githubTheme,
            ),
            child: _CodeEditorActions(
              controller: _rawCtrl!,
              child: TextField(
                controller: _rawCtrl!,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 13,
                ),
                decoration: _editorDecoration(context),
                onChanged: (v) {
                  if (_bodyType == 'json') {
                    widget.onChanged(RequestBody.json(raw: v));
                  } else {
                    widget.onChanged(RequestBody.raw(content: v));
                  }
                },
              ),
            ),
          ),
        );
      case 'x-www-form-urlencoded':
        return _BodyKeyValueEditor.urlEncoded(
          body: widget.body,
          onChanged: widget.onChanged,
        );
      case 'form-data':
        return _BodyKeyValueEditor.formData(
          body: widget.body,
          onChanged: widget.onChanged,
        );
      case 'binary':
        final filePath = switch (widget.body) {
          BinaryBody(filePath: final selectedPath) => selectedPath,
          _ => '',
        };
        final fileLabel = filePath.isEmpty
            ? context.l10n.body_binary_select_file
            : path.basename(filePath);
        return Center(
          child: Tooltip(
            message: filePath,
            child: FilledButton.tonalIcon(
              onPressed: _pickBinaryFile,
              icon: const Icon(FluentIcons.folder_open_16_regular, size: 18),
              label: Text(fileLabel, overflow: TextOverflow.ellipsis),
            ),
          ),
        );
      default:
        return Center(child: Text(context.l10n.body_no_body));
    }
  }

  InputDecoration _editorDecoration(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(4);

    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: cs.primary, width: 1.5),
      ),
    );
  }
}

/// Key-value editor for form-data and url-encoded body types.
///
/// Delegates to [KeyValueTableEditor] for a consistent look with
/// [HeadersEditor] and [ParamsEditor].
class _BodyKeyValueEditor extends StatelessWidget {
  final RequestBody body;
  final ValueChanged<RequestBody> onChanged;
  final bool _isFormData;

  const _BodyKeyValueEditor.urlEncoded({
    required this.body,
    required this.onChanged,
  }) : _isFormData = false;

  const _BodyKeyValueEditor.formData({
    required this.body,
    required this.onChanged,
  }) : _isFormData = true;

  List<KeyValuePair> _toEntries() => switch (body) {
    UrlEncodedBody(params: final p) => p,
    FormDataBody(fields: final f) =>
      f
          .map(
            (ff) => KeyValuePair(key: ff.key, value: ff.value, enabled: true),
          )
          .toList(),
    _ => [],
  };

  void _onChanged(List<KeyValuePair> pairs) {
    if (_isFormData) {
      onChanged(
        RequestBody.formData(
          fields: pairs
              .map((p) => FormField(key: p.key, value: p.value))
              .toList(),
        ),
      );
    } else {
      onChanged(RequestBody.urlEncoded(params: pairs));
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyValueTableEditor(
      entries: _toEntries(),
      onChanged: _onChanged,
      keyHeader: context.l10n.body_key_header,
      valueHeader: context.l10n.body_value_header,
      descHeader: context.l10n.body_value_header,
    );
  }
}

/// Intercepts Tab / Shift+Tab to indent / outdent instead of changing focus,
/// and Ctrl+/ for toggling line comments.
class _CodeEditorActions extends StatelessWidget {
  final CodeController controller;
  final Widget child;

  const _CodeEditorActions({required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        NextFocusIntent: CallbackAction<NextFocusIntent>(
          onInvoke: (_) {
            controller.indentSelection();
            return null;
          },
        ),
        PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(
          onInvoke: (_) {
            controller.outdentSelection();
            return null;
          },
        ),
      },
      child: child,
    );
  }
}
