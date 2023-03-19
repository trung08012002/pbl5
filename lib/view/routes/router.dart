import 'package:flutter/material.dart'
    show GlobalKey, MaterialPage, NavigatorState;
import 'package:go_router/go_router.dart';
import 'package:pbl5/view/routes/routes.dart';

import '../../bloc/bloc/authenticationbloc.dart';
import '../component/home_page.dart';
import '../component/login_screen.dart';
import '../component/sign_page.dart';

class Approuter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  Approuter(AuthenticationBloc bloc);
  static final _router = GoRouter(
      initialLocation: Routes.loginNamedPage,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
            path: Routes.homeNamedPage,
            pageBuilder: (context, state) =>
                MaterialPage(key: state.pageKey, child: HomePage())),
        GoRoute(
          path: Routes.loginNamedPage,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: LoginScreen(),
          ),
        ),
        GoRoute(
          path: Routes.signupNamedPage,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: SignUpScreen(),
          ),
        )
      ]);
  static GoRouter get router => _router;
}
