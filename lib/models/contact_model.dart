class ContactModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String subject;
  final String message;
  final bool isRead;
  final DateTime submittedAt;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.subject,
    required this.message,
    this.isRead = false,
    required this.submittedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      isRead: json['isRead'] ?? false,
      submittedAt: json['submittedAt'] is DateTime
          ? json['submittedAt']
          : DateTime.tryParse(json['submittedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  factory ContactModel.fromFirestore(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      isRead: json['isRead'] ?? false,
      submittedAt: json['submittedAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'message': message,
      'isRead': isRead,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
    bool? isRead,
    DateTime? submittedAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }
}
