import 'package:flutter/material.dart';
import 'package:pbl5/model/repository/authentication_repository.dart';
import 'package:pbl5/view/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp.router(
    routeInformationParser: Approuter.router.routeInformationParser,
    routerDelegate: Approuter.router.routerDelegate,
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.system,
  ));
}
