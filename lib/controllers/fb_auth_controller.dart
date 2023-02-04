import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/firebase_response.dart';

class FbAuthController with Helpers {
  static FbAuthController? _instance;

  FbAuthController._();

  factory FbAuthController() {
    return _instance ??= FbAuthController._();
  }

/*
* 1. CreateAccount
* 2. Sing in
* 3. Forget password
* 4. Sign out
* 5. Get User
* */
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseResponse> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(name);
      await credential.user!.sendEmailVerification();
      await _firebaseAuth.signOut();
      return FirebaseResponse(
          "Account registered successfully, Verify your email, please!",
          credential,
          success: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(e.message ?? "",
          null,
          success: false);
    }
  }

  Future<FirebaseResponse> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      bool emailVerified = credential.user!.emailVerified;
      if (!emailVerified) {
        _firebaseAuth.signOut();
        credential.user!.sendEmailVerification();
      }
      return FirebaseResponse(
          emailVerified
              ? "Logged in successfully"
              : "Failed to login, Verify your email, please!",
          credential,
          success: emailVerified);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(e.message ?? "", null, success: false);
    }
  }

  Future<FirebaseResponse> forgetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FirebaseResponse("Password reset email sent successfully!", null,
          success: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(e.message ?? "", null, success: false);
    }
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  User get user => _firebaseAuth.currentUser!;

  bool get loggedIn => _firebaseAuth.currentUser != null;
}
