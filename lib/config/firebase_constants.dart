/// Firebase collection and document constants
class FirebaseConstants {
  // Collections
  static const String usersCollection = 'users';
  static const String blogPostsCollection = 'blog_posts';
  static const String caseStudiesCollection = 'case_studies';
  static const String testimonialsCollection = 'testimonials';
  static const String recentWorksCollection = 'recent_works';
  static const String contactSubmissionsCollection = 'contact_submissions';

  // Firestore field names
  static const String idField = 'id';
  static const String titleField = 'title';
  static const String descriptionField = 'description';
  static const String contentField = 'content';
  static const String imageUrlField = 'imageUrl';
  static const String imagesField = 'images';
  static const String technologiesField = 'technologies';
  static const String timestampField = 'timestamp';
  static const String createdAtField = 'createdAt';
  static const String updatedAtField = 'updatedAt';
  static const String publishedField = 'published';

  // Storage buckets
  static const String profileImagesFolder = 'profile_images/';
  static const String projectImagesFolder = 'project_images/';
  static const String caseStudyImagesFolder = 'case_study_images/';

  // Firebase error messages
  static const String authErrorUserNotFound = 'user-not-found';
  static const String authErrorInvalidPassword = 'invalid-password';
  static const String authErrorUserDisabled = 'user-disabled';
  static const String authErrorTooManyRequests = 'too-many-requests';
}
