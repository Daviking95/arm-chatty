import 'package:all_flutter_gives/arm_test_code/app_dependencies.dart';
import 'package:all_flutter_gives/arm_test_code/screens/splash_screen.dart';
import 'package:all_flutter_gives/arm_test_code/service/firebase_pn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotificationService.initializeLocalNotificationSetup();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'Login Chat',
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: ThemeData(
            fontFamily: 'Proxima',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
