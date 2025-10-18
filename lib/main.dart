import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:petfinder_app_demo/core/route/app_router.dart';
import 'dart:async';
import 'core/di.dart' as di;
import 'features/fav/data/model/favorite_pet_model.dart';

Future<void> main() async {
   
  WidgetsFlutterBinding.ensureInitialized();
   
     await di.init();

     await Hive.initFlutter();
     Hive.registerAdapter(FavoritePetModelAdapter());
  

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
