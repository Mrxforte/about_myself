class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? bio;
  final String? phone;
  final String? location;
  final String? title;
  final List<String> socialLinks;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.bio,
    this.phone,
    this.location,
    this.title,
    this.socialLinks = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
      bio: json['bio'],
      phone: json['phone'],
      location: json['location'],
      title: json['title'],
      socialLinks: List<String>.from(json['socialLinks'] ?? []),
      createdAt: json['createdAt'] is DateTime
          ? json['createdAt']
          : DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] is DateTime
          ? json['updatedAt']
          : DateTime.tryParse(json['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
      bio: json['bio'],
      phone: json['phone'],
      location: json['location'],
      title: json['title'],
      socialLinks: List<String>.from(json['socialLinks'] ?? []),
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'phone': phone,
      'location': location,
      'title': title,
      'socialLinks': socialLinks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
    String? phone,
    String? location,
    String? title,
    List<String>? socialLinks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      title: title ?? this.title,
      socialLinks: socialLinks ?? this.socialLinks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
