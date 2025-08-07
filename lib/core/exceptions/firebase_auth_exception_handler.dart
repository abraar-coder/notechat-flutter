import 'package:firebase_auth/firebase_auth.dart';
import 'app_exception.dart';

class FirebaseAuthExceptionHandler {
  static AppException handle(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AppException('The email address is not valid.');
      case 'user-disabled':
        return AppException('This user account has been disabled.');
      case 'user-not-found':
        return AppException('No user found with this email.');
      case 'wrong-password':
        return AppException('Incorrect password.');
      case 'email-already-in-use':
        return AppException('This email is already in use.');
      case 'operation-not-allowed':
        return AppException('Email/password accounts are not enabled.');
      case 'weak-password':
        return AppException('The password is too weak.');
      default:
        return AppException('An unexpected error occurred. Code: ${e.code}');
    }
  }
}