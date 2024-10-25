import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthResult {
  final bool isSuccess;
  final UserCredential? userCredential;
  final String? errorMessage;

  AuthResult.success(this.userCredential)
      : isSuccess = true,
        errorMessage = null;

  AuthResult.failure(this.errorMessage)
      : isSuccess = false,
        userCredential = null;
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with email and password
  Future<AuthResult> signInUser(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthResult.success(userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error signing in: ${e.message}';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user';
      } else {
        errorMessage = 'An unknown error occurred. ${e.message}';
      }
      return AuthResult.failure(errorMessage);
    }
  }

  // Sign up with email and password
  Future<AuthResult> signUpUser(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthResult.success(userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error signing up: ${e.message}';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An unknown error occurred: ${e.message}';
      }
      return AuthResult.failure(errorMessage);
    }
  }

  // Google sign in
  Future<AuthResult> signInWithGoogle() async {
    // begin in sign process
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser == null) {
        // user canceled the sign-in
        return AuthResult.failure('Google signing was canceled.');
      }
      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // create new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // finally, sign in
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return AuthResult.success(userCredential);
    } catch (error) {
      return AuthResult.failure(
          'Error signing with Google: ${error.toString()}');
    }
  }

  // Sign out
  Future<AuthResult> signOut() async {
    try {
      // Add a delay before signing out
      await Future.delayed(const Duration(seconds: 2));
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      return AuthResult.success(null); // Sign-out successful
    } catch (error) {
      return AuthResult.failure(
          'Error signing out. Please try again ${error.toString()}');
    }
  }

  // Reset Password
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return AuthResult.success(null);
    } on FirebaseAuthException catch (error) {
      return AuthResult.failure(error.message);
    }
  }
}
