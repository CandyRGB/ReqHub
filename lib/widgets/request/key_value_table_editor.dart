import 'package:flutter/material.dart'
    show
        BoxConstraints,
        Checkbox,
        DataCell,
        DataColumn,
        DataRow,
        DataTable,
        IconButton,
        InputBorder,
        InputDecoration,
        Material,
        MaterialType,
        TextField,
        TextStyle,
        Theme,
        VisualDensity;
import 'package:flutter/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../models/key_value_pair.dart';

/// A reusable editor for key-value pairs displayed in a DataTable.
///
/// Used by both [HeadersEditor] and [ParamsEditor] to avoid code duplication.
class KeyValueTableEditor extends StatefulWidget {
  final List<KeyValuePair> entries;
  final ValueChanged<List<KeyValuePair>> onChanged;
  final String keyHeader;
  final String valueHeader;
  final String descHeader;

  const KeyValueTableEditor({
    super.key,
    required this.entries,
    required this.onChanged,
    required this.keyHeader,
    required this.valueHeader,
    required this.descHeader,
  });

  @override
  State<KeyValueTableEditor> createState() => _KeyValueTableEditorState();
}

class _KeyValueTableEditorState extends State<KeyValueTableEditor> {
  late List<_EditableRow> _rows;

  @override
  void initState() {
    super.initState();
    _rows = widget.entries
        .map(
          (e) => _EditableRow(
            key: e.key,
            value: e.value,
            enabled: e.enabled,
            description: e.description ?? '',
          ),
        )
        .toList();
    if (_rows.isEmpty) _addRow();
  }

  @override
  void didUpdateWidget(covariant KeyValueTableEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entries != widget.entries) {
      _disposeRows();
      _rows = widget.entries
          .map(
            (e) => _EditableRow(
              key: e.key,
              value: e.value,
              enabled: e.enabled,
              description: e.description ?? '',
            ),
          )
          .toList();
      if (_rows.isEmpty) _addRow();
    }
  }

  void _disposeRows() {
    for (final row in _rows) {
      row.dispose();
    }
  }

  @override
  void dispose() {
    _disposeRows();
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _addRow() => setState(() => _rows.add(_EditableRow()));
  void _removeRow(int index) {
    _rows[index].dispose();
    setState(() => _rows.removeAt(index));
    _emitChange();
  }

  void _emitChange() {
    widget.onChanged(
      _rows
          .where((r) => r.key.isNotEmpty)
          .map(
            (r) => KeyValuePair(
              key: r.key,
              value: r.value,
              enabled: r.enabled,
              description: r.description.isNotEmpty ? r.description : null,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tableWidth = constraints.maxWidth;
              const checkColWidth = 24.0;
              const deleteColWidth = 36.0;
              const fixedWidth = checkColWidth + deleteColWidth;
              final flexTotal = 2.0 + 3.0 + 3.0; // key + value + description
              final flexUnit = (tableWidth - fixedWidth) / flexTotal;
              final keyWidth = 2 * flexUnit;
              final valueWidth = 3 * flexUnit;
              final descWidth = 3 * flexUnit;

              // Full grid: outer box + column/row dividers so rows are easy
              // to recognize. Row lines come from horizontalInside, not
              // dividerThickness (otherwise they would be doubled).
              final innerBorder = cs.outlineVariant.withValues(alpha: 0.7);
              final outerBorder = cs.outlineVariant;

              return Material(
                type: MaterialType.transparency,
                child: SingleChildScrollView(
                  child: DataTable(
                    showCheckboxColumn: false,
                    horizontalMargin: 0,
                    columnSpacing: 0,
                    dataRowMinHeight: 36,
                    dataRowMaxHeight: 36,
                    headingRowHeight: 32,
                    dividerThickness: 0,
                    headingRowColor: WidgetStateProperty.all(
                      const Color(0x08000000),
                    ),
                    border: TableBorder(
                      top: BorderSide(color: outerBorder),
                      bottom: BorderSide(color: outerBorder),
                      left: BorderSide(color: outerBorder),
                      right: BorderSide(color: outerBorder),
                      horizontalInside: BorderSide(color: innerBorder),
                      verticalInside: BorderSide(color: innerBorder),
                    ),
                    columns: [
                      const DataColumn(label: SizedBox(width: checkColWidth)),
                      DataColumn(
                        label: SizedBox(
                          width: keyWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              widget.keyHeader,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: valueWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              widget.valueHeader,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: descWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              widget.descHeader,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: deleteColWidth,
                          child: Center(
                            child: _TableIconButton(
                              icon: FluentIcons.add_16_regular,
                              onPressed: _addRow,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(_rows.length, (index) {
                      final row = _rows[index];
                      return DataRow(
                        color: WidgetStateProperty.resolveWith((states) {
                          if (index.isOdd) return const Color(0x04000000);
                          return null;
                        }),
                        cells: [
                          DataCell(
                            Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: FittedBox(
                                  child: Checkbox(
                                    value: row.enabled,
                                    onChanged: (v) {
                                      setState(() => row.enabled = v ?? true);
                                      _emitChange();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: keyWidth,
                              child: TextField(
                                controller: row.keyCtrl,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: 13),
                                onChanged: (v) => _emitChange(),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: valueWidth,
                              child: TextField(
                                controller: row.valueCtrl,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: 13),
                                onChanged: (v) => _emitChange(),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: descWidth,
                              child: TextField(
                                controller: row.descCtrl,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: 13),
                                onChanged: (v) => _emitChange(),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: _TableIconButton(
                                icon: FluentIcons.subtract_16_regular,
                                onPressed: () => _removeRow(index),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// A shrink-to-icon [IconButton] for table cells.
///
/// Without these constraints the default 48x48 tap target inflates the
/// column past its declared width and pushes the icon off-center.
class _TableIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _TableIconButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 18),
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
    );
  }
}

class _EditableRow {
  final TextEditingController keyCtrl;
  final TextEditingController valueCtrl;
  final TextEditingController descCtrl;

  String get key => keyCtrl.text;
  set key(String v) => keyCtrl.text = v;
  String get value => valueCtrl.text;
  set value(String v) => valueCtrl.text = v;
  String get description => descCtrl.text;
  set description(String v) => descCtrl.text = v;

  bool enabled;

  _EditableRow({
    String key = '',
    String value = '',
    String description = '',
    this.enabled = true,
  }) : keyCtrl = TextEditingController(text: key),
       valueCtrl = TextEditingController(text: value),
       descCtrl = TextEditingController(text: description);

  void dispose() {
    keyCtrl.dispose();
    valueCtrl.dispose();
    descCtrl.dispose();
  }
}
