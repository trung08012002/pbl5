import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../data/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  
}
