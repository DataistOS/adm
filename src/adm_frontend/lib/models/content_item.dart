class ContentItem {
  final String id;
  final String name;
  final int size;
  final String formattedSize;
  final String extension;

  ContentItem({
    required this.id,
    required this.name,
    required this.size,
    required this.formattedSize,
    required this.extension,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      size: json['size'] ?? 0,
      formattedSize: json['formatted_size'] ?? '',
      extension: json['extension'] ?? '',
    );
  }
}

class CategoryContent {
  final String id;
  final String title;
  final String desc;
  final String formattedSize;
  final List<ContentItem> items;

  CategoryContent({
    required this.id,
    required this.title,
    required this.desc,
    required this.formattedSize,
    required this.items,
  });

  factory CategoryContent.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List? ?? [];
    List<ContentItem> parsedItems = list
        .map((i) => ContentItem.fromJson(i))
        .toList();

    return CategoryContent(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      formattedSize: json['formatted_size'] ?? '0 B',
      items: parsedItems,
    );
  }
}
