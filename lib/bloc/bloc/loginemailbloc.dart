import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as facebook
    show LoginStatus;
import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pbl5/model/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../model/data/user.dart';
import '../../util/googleloginexception.dart';
import '../state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(const LoginState()) {
    _userSubCription = _authenticationRepository.user.listen((user) {
      currentUser = user;
    });
  }
  User? currentUser;
  late final StreamSubscription<User> _userSubCription;
  Future<LoginState> googleLogin() async {
    try {
      final credential = await _authenticationRepository.signInWithGoogle();
      final user = currentUser;
      if (user != null) {
        return state.copywith(
            email: user.email,
            name: user.name,
            urlPhoto: user.photo,
            isNewUser: credential.additionalUserInfo?.isNewUser,
            status: LoginStatus.submissionSuccess);
      }
      return state;
    } on firebase_auth.FirebaseAuthException catch (e) {
      final error = LogInWithGoogleFailure.fromCode(e.code);
      return state.copywith(errorMessage: error.message);
    } catch (_) {
      const error = LogInWithGoogleFailure();
      return state.copywith(errorMessage: error.message);
    }
  }

  Future<LoginState> signInWithFacebook() async {
    try {
      final result = await _authenticationRepository.signInWithFacebook();
      switch (result.loginstatus) {
        case facebook.LoginStatus.success:
          final user = currentUser;
          if (user != null) {
            return state.copywith(
                email: user.email,
                name: user.name,
                urlPhoto: user.photo,
                isNewUser: result.userCredential!.additionalUserInfo?.isNewUser,
                status: LoginStatus.submissionSuccess);
          }
          return state;
        case facebook.LoginStatus.cancelled:
          return state.copywith(status: LoginStatus.userCancel);
        case facebook.LoginStatus.failed:
          return state.copywith(status: LoginStatus.submissionFailure);
        case facebook.LoginStatus.operationInProgress:
          return state.copywith(status: LoginStatus.submissionInProgress);
      }
    } catch (_) {
      return state.copywith(status: LoginStatus.submissionFailure);
    }
  }
}
