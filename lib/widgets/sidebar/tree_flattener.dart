import '../../../models/collection.dart';
import '../../../models/http_request.dart';
import 'tree_entry.dart';

/// Flatten the nested collection tree + root requests into a linear list
/// for rendering in a ListView.
List<TreeEntry> flattenTree(
  List<Collection> collections,
  List<HttpRequestModel> rootRequests,
  Set<String> expanded,
) {
  final list = <TreeEntry>[];
  // Root requests first
  for (final req in rootRequests) {
    list.add(
      TreeEntry(
        depth: 0,
        kind: TreeEntryKind.request,
        id: req.id,
        name: req.name,
        method: req.method,
        parentId: null,
      ),
    );
  }
  for (final c in collections) {
    _addCollection(list, c, 0, null, expanded);
  }
  return list;
}

void _addCollection(
  List<TreeEntry> list,
  Collection col,
  int depth,
  String? parentId,
  Set<String> expanded,
) {
  final hasKids = col.children.isNotEmpty || col.requests.isNotEmpty;
  list.add(
    TreeEntry(
      depth: depth,
      kind: TreeEntryKind.collection,
      id: col.id,
      name: col.name,
      hasChildren: hasKids,
      parentId: parentId,
    ),
  );
  if (expanded.contains(col.id)) {
    for (final child in col.children) {
      _addCollection(list, child, depth + 1, col.id, expanded);
    }
    for (final req in col.requests) {
      list.add(
        TreeEntry(
          depth: depth + 1,
          kind: TreeEntryKind.request,
          id: req.id,
          name: req.name,
          method: req.method,
          parentId: col.id,
        ),
      );
    }
  }
}
