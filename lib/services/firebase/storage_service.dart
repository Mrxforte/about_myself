import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Firebase Storage service for file uploads
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload profile image
  Future<String> uploadProfileImage({
    required String userId,
    required File imageFile,
  }) async {
    try {
      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}';
      final path = '${FirebaseConstants.profileImagesFolder}$fileName';

      final ref = _storage.ref().child(path);
      await ref.putFile(imageFile);

      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  /// Upload project/case study image
  Future<String> uploadProjectImage({
    required String projectId,
    required File imageFile,
  }) async {
    try {
      final fileName = '$projectId-${DateTime.now().millisecondsSinceEpoch}';
      final path = '${FirebaseConstants.projectImagesFolder}$fileName';

      final ref = _storage.ref().child(path);
      await ref.putFile(imageFile);

      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload project image: $e');
    }
  }

  /// Upload multiple images
  Future<List<String>> uploadMultipleImages({
    required String folder,
    required List<File> imageFiles,
  }) async {
    try {
      final List<String> urls = [];

      for (final file in imageFiles) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}';
        final path = '$folder$fileName';

        final ref = _storage.ref().child(path);
        await ref.putFile(file);

        final url = await ref.getDownloadURL();
        urls.add(url);
      }

      return urls;
    } catch (e) {
      throw Exception('Failed to upload images: $e');
    }
  }

  /// Delete file from storage
  Future<void> deleteFile({required String filePath}) async {
    try {
      await _storage.ref().child(filePath).delete();
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  /// Get download URL for a file
  Future<String> getDownloadURL({required String filePath}) async {
    try {
      return await _storage.ref().child(filePath).getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get download URL: $e');
    }
  }
}
