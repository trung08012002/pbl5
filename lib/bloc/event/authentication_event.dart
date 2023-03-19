import 'package:equatable/equatable.dart';

import '../../model/data/user.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

abstract class UserAuthencticationEvent extends AuthenticationEvent {
  final User user;
  const UserAuthencticationEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class AppUserChanged extends UserAuthencticationEvent {
  const AppUserChanged({required super.user});
}

class AppLogoutRequested extends AuthenticationEvent {
  const AppLogoutRequested();
}
