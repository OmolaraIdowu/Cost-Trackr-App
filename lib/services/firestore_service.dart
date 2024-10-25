import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_trackr/model/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserData?> getUserData(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) return null;
      return UserData(
          uid: uid,
          name: userDoc['name'],
          email: userDoc['email'],
          imageUrl: userDoc['image_url']);
    } catch (error) {
      throw Exception('Error fetching user data: $error');
    }
  }

  saveUserData(UserData userData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userData.uid)
          .set(userData.toMap(), SetOptions(merge: true));
    } catch (error) {
      throw Exception('Error saving user data: $error');
    }
  }
}
