import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadUserImage(String uid, File? imageFile) async {
    if (imageFile == null) {
      throw Exception('No image selected.');
    }
    try {
      final storageRef =
          _firebaseStorage.ref().child('profile_images').child('$uid.jpg');

      // Upload the image file
      await storageRef.putFile(imageFile);

      // Get the download URL after the upload
      final imageUrl = await storageRef.getDownloadURL();
      // Return the image URL after upload
      return imageUrl;
    } catch (error) {
      throw Exception('Error uploading image: $error');
    }
  }
}

// Future<void> uploadImage(String uid, File image) async {
//   try {
//     // Upload image to Firebase Storage
//     final storageRef = FirebaseStorage.instance.ref().child('user_images/$uid.jpg');
//     await storageRef.putFile(image);
//
//     // Get the download URL
//     final imageUrl = await storageRef.getDownloadURL();
//
//     // Update user data with the new image URL
//     await FirestoreService().updateUserData(uid, {'image_url': imageUrl});
//   } catch (e) {
//     throw Exception('Image upload failed: $e');
//   }
// }
