import 'package:equatable/equatable.dart';
import '../../model/data/user.dart';

enum AppStatus { authenticated, unauthenticated}

class AuthenticationState extends Equatable {
  final AppStatus status;
  final User user;
  const AuthenticationState({required this.status, this.user = User.empty});
  const AuthenticationState.authenticated(this.user)
      : status = AppStatus.authenticated;

  const AuthenticationState.unauthenticated()
      : status = AppStatus.unauthenticated,
        user = User.empty;

  @override
  List<Object> get props => [status, user];
}
