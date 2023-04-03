import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginResultFaceBook {
  final UserCredential? userCredential;
  final LoginStatus loginstatus;
  LoginResultFaceBook({this.userCredential, required this.loginstatus});
}
