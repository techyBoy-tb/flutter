import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/screens/wrapper.dart';
import 'package:flutter_sandbox/services/authService.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/CustomUser.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .whenComplete(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>(
      // value: AuthService().user,
      create: (_) => AuthService().user,
      initialData: null,
      lazy: false,
      catchError: (_, __) => null,
      child: MaterialApp(
        title: 'Movie app',
        theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'poppins',
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  color: Colors.white,
                ),
                bodyLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            scaffoldBackgroundColor: const Color(0xFF191a2c),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder()
            })),
        debugShowCheckedModeBanner: false,
        color: Colors.green,
        home: const Wrapper(),
      ),
    );
  }
}
