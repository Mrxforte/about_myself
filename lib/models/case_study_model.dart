class CaseStudyModel {
  final String id;
  final String title;
  final String description;
  final String? content;
  final List<String> images;
  final List<String> technologies;
  final String? clientName;
  final String? projectDuration;
  final String? role;
  final String? liveLink;
  final String? githubLink;
  final int? viewCount;
  final bool published;
  final DateTime createdAt;
  final DateTime updatedAt;

  CaseStudyModel({
    required this.id,
    required this.title,
    required this.description,
    this.content,
    this.images = const [],
    this.technologies = const [],
    this.clientName,
    this.projectDuration,
    this.role,
    this.liveLink,
    this.githubLink,
    this.viewCount = 0,
    this.published = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CaseStudyModel.fromJson(Map<String, dynamic> json) {
    return CaseStudyModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'],
      images: List<String>.from(json['images'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      clientName: json['clientName'],
      projectDuration: json['projectDuration'],
      role: json['role'],
      liveLink: json['liveLink'],
      githubLink: json['githubLink'],
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

  factory CaseStudyModel.fromFirestore(Map<String, dynamic> json) {
    return CaseStudyModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'],
      images: List<String>.from(json['images'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      clientName: json['clientName'],
      projectDuration: json['projectDuration'],
      role: json['role'],
      liveLink: json['liveLink'],
      githubLink: json['githubLink'],
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
      'content': content,
      'images': images,
      'technologies': technologies,
      'clientName': clientName,
      'projectDuration': projectDuration,
      'role': role,
      'liveLink': liveLink,
      'githubLink': githubLink,
      'viewCount': viewCount,
      'published': published,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  CaseStudyModel copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    List<String>? images,
    List<String>? technologies,
    String? clientName,
    String? projectDuration,
    String? role,
    String? liveLink,
    String? githubLink,
    int? viewCount,
    bool? published,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CaseStudyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      images: images ?? this.images,
      technologies: technologies ?? this.technologies,
      clientName: clientName ?? this.clientName,
      projectDuration: projectDuration ?? this.projectDuration,
      role: role ?? this.role,
      liveLink: liveLink ?? this.liveLink,
      githubLink: githubLink ?? this.githubLink,
      viewCount: viewCount ?? this.viewCount,
      published: published ?? this.published,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
