class RecentWorkModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final List<String> technologies;
  final String? liveLink;
  final String? githubLink;
  final String? category;
  final int? viewCount;
  final bool published;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecentWorkModel({
    required this.id,
    required this.title,
    required this.description,
    this.images = const [],
    this.technologies = const [],
    this.liveLink,
    this.githubLink,
    this.category,
    this.viewCount = 0,
    this.published = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecentWorkModel.fromJson(Map<String, dynamic> json) {
    return RecentWorkModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      liveLink: json['liveLink'],
      githubLink: json['githubLink'],
      category: json['category'],
      viewCount: json['viewCount'] ?? 0,
      published: json['published'] ?? true,
      createdAt: json['createdAt'] is DateTime
          ? json['createdAt']
          : DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] is DateTime
          ? json['updatedAt']
          : DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  factory RecentWorkModel.fromFirestore(Map<String, dynamic> json) {
    return RecentWorkModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      liveLink: json['liveLink'],
      githubLink: json['githubLink'],
      category: json['category'],
      viewCount: json['viewCount'] ?? 0,
      published: json['published'] ?? true,
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'technologies': technologies,
      'liveLink': liveLink,
      'githubLink': githubLink,
      'category': category,
      'viewCount': viewCount,
      'published': published,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  RecentWorkModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? images,
    List<String>? technologies,
    String? liveLink,
    String? githubLink,
    String? category,
    int? viewCount,
    bool? published,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecentWorkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      technologies: technologies ?? this.technologies,
      liveLink: liveLink ?? this.liveLink,
      githubLink: githubLink ?? this.githubLink,
      category: category ?? this.category,
      viewCount: viewCount ?? this.viewCount,
      published: published ?? this.published,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
