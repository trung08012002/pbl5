import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:pbl5/model/repository/login_result_facebook.dart';
import '../data/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as facebook
    show FacebookAuth, LoginResult, LoginStatus;

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  var currentUser = User.empty;
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseuser) {
      final user = firebaseuser == null ? User.empty : firebaseuser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> logout() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
  }

  Future<firebase_auth.UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await firebase_auth.FirebaseAuth.instance
        .signInWithCredential(credential);
  }

  Future<LoginResultFaceBook> signInWithFacebook() async {
    final facebook.LoginResult loginResult =
        await facebook.FacebookAuth.instance.login();
    switch (loginResult.status) {
      case facebook.LoginStatus.success:
        final firebase_auth.OAuthCredential facebookAuthCredential =
            firebase_auth.FacebookAuthProvider.credential(
                loginResult.accessToken!.token);
        return LoginResultFaceBook(
            userCredential: await firebase_auth.FirebaseAuth.instance
                .signInWithCredential(facebookAuthCredential),
            loginstatus: facebook.LoginStatus.success);
      case facebook.LoginStatus.cancelled:
        return LoginResultFaceBook(loginstatus: facebook.LoginStatus.cancelled);
      case facebook.LoginStatus.failed:
        return LoginResultFaceBook(loginstatus: facebook.LoginStatus.failed);
      case facebook.LoginStatus.operationInProgress:
        return LoginResultFaceBook(
            loginstatus: facebook.LoginStatus.operationInProgress);
    }
  }
}

extension ToUser on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
