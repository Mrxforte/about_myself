class TestimonialModel {
  final String id;
  final String authorName;
  final String authorRole;
  final String? authorImage;
  final String? authorCompany;
  final String content;
  final double rating;
  final bool published;
  final DateTime createdAt;
  final DateTime updatedAt;

  TestimonialModel({
    required this.id,
    required this.authorName,
    required this.authorRole,
    this.authorImage,
    this.authorCompany,
    required this.content,
    this.rating = 5.0,
    this.published = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] ?? '',
      authorName: json['authorName'] ?? '',
      authorRole: json['authorRole'] ?? '',
      authorImage: json['authorImage'],
      authorCompany: json['authorCompany'],
      content: json['content'] ?? '',
      rating: (json['rating'] ?? 5.0).toDouble(),
      published: json['published'] ?? true,
      createdAt: json['createdAt'] is DateTime
          ? json['createdAt']
          : DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] is DateTime
          ? json['updatedAt']
          : DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  factory TestimonialModel.fromFirestore(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] ?? '',
      authorName: json['authorName'] ?? '',
      authorRole: json['authorRole'] ?? '',
      authorImage: json['authorImage'],
      authorCompany: json['authorCompany'],
      content: json['content'] ?? '',
      rating: (json['rating'] ?? 5.0).toDouble(),
      published: json['published'] ?? true,
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorRole': authorRole,
      'authorImage': authorImage,
      'authorCompany': authorCompany,
      'content': content,
      'rating': rating,
      'published': published,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  TestimonialModel copyWith({
    String? id,
    String? authorName,
    String? authorRole,
    String? authorImage,
    String? authorCompany,
    String? content,
    double? rating,
    bool? published,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TestimonialModel(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorRole: authorRole ?? this.authorRole,
      authorImage: authorImage ?? this.authorImage,
      authorCompany: authorCompany ?? this.authorCompany,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      published: published ?? this.published,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
