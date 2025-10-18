import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petfinder_app_demo/core/route/app_router.dart';
import 'dart:async';
import 'core/di.dart' as di;

Future<void> main() async {
   
  WidgetsFlutterBinding.ensureInitialized();
   
     await di.init();

    await dotenv.load(fileName: ".env");

  runZonedGuarded(
    () {
      runApp(MyApp());
    },
    (error, stack) {
      print('Uncaught error in zone: $error\n$stack');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Petfinder App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
    );
  }
}
