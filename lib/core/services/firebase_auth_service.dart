import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:note_chat/core/exceptions/app_exception.dart';
import 'package:note_chat/core/exceptions/platform_exception_handler.dart';
import '../exceptions/firebase_auth_exception_handler.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // 👤 Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // 📡 Auth state changes stream
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // ✅ Register with Email & Password
  Future<User> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } on PlatformException catch (e) {
      throw PlatformExceptionHandler.handle(e);
    } catch (e) {
      throw AppException('Something went wrong. Please try again.');
    }
  }

  // ✅ Login with Email & Password
  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } on PlatformException catch (e) {
      throw PlatformExceptionHandler.handle(e);
    } catch (e) {
      throw AppException('Something went wrong. Please try again.');
    }
  }

  // ✅ Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } on PlatformException catch (e) {
      throw PlatformExceptionHandler.handle(e);
    } catch (e) {
      throw AppException('Something went wrong. Please try again.');
    }
  }

  // ✅ Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AppException('Sign out failed. Please try again.');
    }
  }

  // ✅ Anonymous Sign In
  Future<User> signInAnonymously() async {
    try {
      final result = await _firebaseAuth.signInAnonymously();
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } on PlatformException catch (e) {
      throw PlatformExceptionHandler.handle(e);
    } catch (e) {
      throw AppException('Something went wrong. Please try again.');
    }
  }
}
