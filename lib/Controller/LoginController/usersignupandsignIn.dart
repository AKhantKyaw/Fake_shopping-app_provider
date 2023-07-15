// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app_with_provider/Controller/LoginController/errorheldaling.dart';

class UserAuthentication {
  static final auth = FirebaseAuth.instance;
  AuthStatus status = AuthStatus.emailAlreadyExists;
  Future<AuthStatus> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(newUser.additionalUserInfo);
      auth.currentUser!.updateDisplayName(name);
      status = AuthStatus.successful;
      print(status);
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
      print(status);
    }
    return status;
  }

  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential newUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(newUser.additionalUserInfo);
      status = AuthStatus.successful;
      print(status);
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
      print(status);
    }
    return status;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => status = AuthStatus.successful)
        .catchError(
            (e) => status = AuthExceptionHandler.handleAuthException(e));

    return status;
  }
}
