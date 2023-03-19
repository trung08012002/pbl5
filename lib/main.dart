import 'package:flutter/material.dart';
import 'package:pbl5/view/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final router = Approuter();
  runApp(MaterialApp.router(
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.system,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
