import 'package:flutter/material.dart'
    show GlobalKey, MaterialPage, NavigatorState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl5/model/repository/authentication_repository.dart';
import 'package:pbl5/view/routes/routes.dart';

import '../../bloc/bloc/authenticationbloc.dart';
import '../component/home_page.dart';
import '../component/login_screen.dart';
import '../component/sign_page.dart';

class Approuter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final AuthRepository respository = AuthRepository();
  static final AuthenticationBloc _bloc = AuthenticationBloc(respository);
  static final _router = GoRouter(
      initialLocation: Routes.loginNamedPage,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
            name: Routes.homeNamedPage,
            path: Routes.homeRoute,
            pageBuilder: (context, state) => 
                 MaterialPage(key: state.pageKey, child: BlocProvider.value(
                  value: _bloc,
                  child: const HomePage())),
             routes: [
             ]),
        GoRoute(
          name: Routes.loginNamedPage,
          path:Routes.loginRoute,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: BlocProvider.value(
                  value: _bloc,
            child:const LoginScreen(),
            )
          ),
        ),
        GoRoute(
          name: Routes.signupNamedPage,
          path:Routes.signupRoute,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
           child: BlocProvider.value(
                  value: _bloc,
                  child:const SignUpScreen(),
           )
          ),
        )
      ]);
  static GoRouter get router => _router;
  void dispose() {
    _bloc.close();
  }
}
