/// Kind of a node in the flat tree list.
enum TreeEntryKind { collection, request }

/// One flattened entry in the tree list.
class TreeEntry {
  final int depth;
  final TreeEntryKind kind;
  final String id;
  final String name;
  final String? method;
  final bool hasChildren; // only for collections
  final String? parentId; // null for root-level collections / root requests

  const TreeEntry({
    required this.depth,
    required this.kind,
    required this.id,
    required this.name,
    this.method,
    this.hasChildren = false,
    this.parentId,
  });

  bool get isCollection => kind == TreeEntryKind.collection;
}
