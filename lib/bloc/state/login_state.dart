import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum LoginStatus {
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  userCancel
}

@immutable
class LoginState extends Equatable {
  const LoginState(
      {this.email = "",
      this.name = "",
      this.urlPhoto = "",
      this.isNewUser = false,
      this.status = LoginStatus.submissionInProgress,
      this.errorMessage});
  final String email;
  final String name;
  final String urlPhoto;
  final bool isNewUser;
  final LoginStatus status;
  final String? errorMessage;
  LoginState copywith(
          {String? email,
          String? name,
          String? urlPhoto,
          bool? isNewUser,
          LoginStatus? status,
          String? errorMessage}) =>
      LoginState(
          email: email ?? this.email,
          name: name ?? this.name,
          urlPhoto: urlPhoto ?? this.urlPhoto,
          isNewUser: isNewUser ?? this.isNewUser,
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [email, name, urlPhoto, isNewUser];
}
