import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  const UserData({
    required this.uid,
    required this.name,
    required this.email,
    this.imageUrl,
  });
  final String uid;
  final String name;
  final String email;
  final String? imageUrl;

  // Convert the UserData instance into a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image_url': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  UserData copyWith({String? name, String? imageUrl}) {
    return UserData(
        uid: uid,
        name: name ?? this.name,
        email: email,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
