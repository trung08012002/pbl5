import 'dart:async';
import '../../model/data/user.dart';
import '../../model/repository/authentication_repository.dart';
import '../event/authentication_event.dart';
import '../state/authentication_state.dart';
import 'package:bloc/bloc.dart';
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authrepo;
  AuthenticationBloc(AuthRepository authrepo)
      : _authrepo = authrepo,
        super(authrepo.currentUser.isNotEmpty
            ? AuthenticationState.authenticated(authrepo.currentUser)
            : const AuthenticationState.unauthenticated()) {
    on<AppUserChanged>(onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authrepo.user.listen(
      (user) => add(AppUserChanged(user: user)),
    );
  }
  late final StreamSubscription<User> _userSubscription;
  void onUserChanged(
      UserAuthencticationEvent event, Emitter<AuthenticationState> emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _onLogoutRequested(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    unawaited(_authrepo.logout());
  }


  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
