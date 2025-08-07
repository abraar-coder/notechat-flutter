import 'package:firebase_storage/firebase_storage.dart';
import 'app_exception.dart';

class FirebaseStorageExceptionHandler {
  static AppException handle(FirebaseException e) {
    switch (e.code) {
      case 'object-not-found':
        return AppException('File not found.');
      case 'unauthorized':
        return AppException('You don\'t have permission to access this file.');
      case 'cancelled':
        return AppException('The upload was cancelled.');
      case 'unknown':
      default:
        return AppException('An unknown storage error occurred.');
    }
  }
}
