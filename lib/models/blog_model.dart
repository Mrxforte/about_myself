class BlogModel {
  final String id;
  final String title;
  final String content;
  final DateTime publishedDate;
  final String? imageUrl;
  final String? excerpt;
  final List<String> tags;
  final bool published;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedDate,
    this.imageUrl,
    this.excerpt,
    this.tags = const [],
    this.published = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      publishedDate: json['publishedDate'] != null
          ? DateTime.parse(json['publishedDate'])
          : DateTime.now(),
      imageUrl: json['imageUrl'],
      excerpt: json['excerpt'],
      tags: List<String>.from(json['tags'] ?? []),
      published: json['published'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  factory BlogModel.fromFirestore(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      publishedDate: json['publishedDate'] is DateTime
          ? json['publishedDate']
          : DateTime.tryParse(json['publishedDate']?.toString() ?? '') ?? DateTime.now(),
      imageUrl: json['imageUrl'],
      excerpt: json['excerpt'],
      tags: List<String>.from(json['tags'] ?? []),
      published: json['published'] ?? true,
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'publishedDate': publishedDate.toIso8601String(),
      'imageUrl': imageUrl,
      'excerpt': excerpt,
      'tags': tags,
      'published': published,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? publishedDate,
    String? imageUrl,
    String? excerpt,
    List<String>? tags,
    bool? published,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      publishedDate: publishedDate ?? this.publishedDate,
      imageUrl: imageUrl ?? this.imageUrl,
      excerpt: excerpt ?? this.excerpt,
      tags: tags ?? this.tags,
      published: published ?? this.published,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}