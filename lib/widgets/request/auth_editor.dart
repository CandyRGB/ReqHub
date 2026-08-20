import 'package:flutter/material.dart';

import '../../extensions/localization_ext.dart';
import '../../models/http_request.dart';

class AuthEditor extends StatefulWidget {
  final AuthConfig auth;
  final ValueChanged<AuthConfig> onChanged;

  const AuthEditor({super.key, required this.auth, required this.onChanged});

  @override
  State<AuthEditor> createState() => _AuthEditorState();
}

class _AuthEditorState extends State<AuthEditor> {
  late TextEditingController? _ctrl1;
  late TextEditingController? _ctrl2;
  late TextEditingController? _ctrl3;

  /// Only used for SegmentedButton display and the transition guard in
  /// [_buildAuthFields]. All type logic uses [widget.auth] directly via
  /// pattern matching — this field is never used for `as` casts.
  String _selectedType = 'none';

  static String _labelOf(AuthConfig a) => switch (a) {
    NoAuth() => 'none',
    BasicAuth() => 'basic',
    BearerAuth() => 'bearer',
    ApiKeyAuth() => 'apikey',
    _ => 'none',
  };

  @override
  void initState() {
    super.initState();
    _selectedType = _labelOf(widget.auth);
    _initCtrls();
  }

  @override
  void didUpdateWidget(covariant AuthEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_labelOf(oldWidget.auth) != _labelOf(widget.auth)) {
      _disposeCtrls();
      _selectedType = _labelOf(widget.auth);
      _initCtrls();
    } else {
      _syncCtrls(widget.auth, oldWidget.auth);
    }
  }

  @override
  void dispose() {
    _disposeCtrls();
    super.dispose();
  }

  void _initCtrls() {
    switch (widget.auth) {
      case BasicAuth(username: final username, password: final password):
        _ctrl1 = TextEditingController(text: username);
        _ctrl2 = TextEditingController(text: password);
        _ctrl3 = null;
      case BearerAuth(token: final token):
        _ctrl1 = TextEditingController(text: token);
        _ctrl2 = null;
        _ctrl3 = null;
      case ApiKeyAuth(key: final key, value: final value):
        _ctrl1 = TextEditingController(text: key);
        _ctrl2 = TextEditingController(text: value);
        _ctrl3 = null;
      case NoAuth():
        _ctrl1 = null;
        _ctrl2 = null;
        _ctrl3 = null;
      default:
        _ctrl1 = null;
        _ctrl2 = null;
        _ctrl3 = null;
    }
  }

  void _syncCtrls(AuthConfig curr, AuthConfig old) {
    switch ((curr, old)) {
      case (
        BasicAuth(username: final username, password: final password),
        BasicAuth(username: final oldUser, password: final oldPass),
      ):
        if (username != oldUser && username != _ctrl1!.text) {
          _ctrl1!.text = username;
        }
        if (password != oldPass && password != _ctrl2!.text) {
          _ctrl2!.text = password;
        }
      case (BearerAuth(token: final token), BearerAuth(token: final oldToken)):
        if (token != oldToken && token != _ctrl1!.text) {
          _ctrl1!.text = token;
        }
      case (
        ApiKeyAuth(key: final key, value: final value),
        ApiKeyAuth(key: final oldKey, value: final oldValue),
      ):
        if (key != oldKey && key != _ctrl1!.text) {
          _ctrl1!.text = key;
        }
        if (value != oldValue && value != _ctrl2!.text) {
          _ctrl2!.text = value;
        }
      default:
        break; // Type mismatch — guarded by didUpdateWidget
    }
  }

  void _disposeCtrls() {
    _ctrl1?.dispose();
    _ctrl2?.dispose();
    _ctrl3?.dispose();
  }

  void _setType(String type) {
    _disposeCtrls();
    _ctrl1 = null;
    _ctrl2 = null;
    _ctrl3 = null;
    setState(() => _selectedType = type);
    widget.onChanged(switch (type) {
      'none' => const AuthConfig.noAuth(),
      'basic' => const AuthConfig.basic(),
      'bearer' => const AuthConfig.bearer(),
      'apikey' => const AuthConfig.apiKey(),
      _ => const AuthConfig.noAuth(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Text(
                context.l10n.auth_type_label,
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
                    value: 'basic',
                    label: Text('basic', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'bearer',
                    label: Text('bearer', style: TextStyle(fontSize: 12)),
                  ),
                  ButtonSegment(
                    value: 'apikey',
                    label: Text('apikey', style: TextStyle(fontSize: 12)),
                  ),
                ],
                selected: {_selectedType},
                onSelectionChanged: (v) => _setType(v.first),
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
        const Divider(height: 1),
        Expanded(child: _buildAuthFields()),
      ],
    );
  }

  Widget _buildAuthFields() {
    // During transition: _setType updated _selectedType but parent hasn't
    // rebuilt yet — show nothing until widget.auth catches up.
    if (_labelOf(widget.auth) != _selectedType) {
      return const SizedBox.shrink();
    }
    return switch (widget.auth) {
      BasicAuth auth => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            _LabeledField(
              label: context.l10n.auth_username,
              child: TextField(
                controller: _ctrl1,
                onChanged: (v) => widget.onChanged(auth.copyWith(username: v)),
                decoration: _fieldDecoration(),
              ),
            ),
            const SizedBox(height: 10),
            _LabeledField(
              label: context.l10n.auth_password,
              child: TextField(
                controller: _ctrl2,
                obscureText: true,
                onChanged: (v) => widget.onChanged(auth.copyWith(password: v)),
                decoration: _fieldDecoration(),
              ),
            ),
          ],
        ),
      ),
      BearerAuth auth => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: _LabeledField(
          label: context.l10n.auth_token,
          child: TextField(
            controller: _ctrl1,
            onChanged: (v) => widget.onChanged(auth.copyWith(token: v)),
            decoration: _fieldDecoration().copyWith(
              hintText: context.l10n.auth_token_hint,
            ),
          ),
        ),
      ),
      ApiKeyAuth auth => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  context.l10n.auth_add_to,
                  style: const TextStyle(fontSize: 13),
                ),
                const Spacer(),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'header',
                      label: Text('header', style: TextStyle(fontSize: 12)),
                    ),
                    ButtonSegment(
                      value: 'query',
                      label: Text('query', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                  selected: {auth.addTo},
                  onSelectionChanged: (v) =>
                      widget.onChanged(auth.copyWith(addTo: v.first)),
                  showSelectedIcon: false,
                  emptySelectionAllowed: false,
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _LabeledField(
              label: context.l10n.auth_key,
              child: TextField(
                controller: _ctrl1,
                onChanged: (v) => widget.onChanged(auth.copyWith(key: v)),
                decoration: _fieldDecoration(),
              ),
            ),
            const SizedBox(height: 10),
            _LabeledField(
              label: context.l10n.auth_value,
              child: TextField(
                controller: _ctrl2,
                onChanged: (v) => widget.onChanged(auth.copyWith(value: v)),
                decoration: _fieldDecoration(),
              ),
            ),
          ],
        ),
      ),
      NoAuth() => Center(
        child: Text(
          context.l10n.auth_no_auth,
          style: const TextStyle(fontSize: 13),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }

  static InputDecoration _fieldDecoration() => const InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    border: InputBorder.none,
  );
}

/// A row with a label on the left and a field on the right.
class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label, style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 8),
        Expanded(child: child),
      ],
    );
  }
}
