import 'package:firebase/firebase_options.dart';
import 'package:firebase/models/CustomUser.dart';
import 'package:firebase/screens/wrapper.dart';
import 'package:firebase/services/authService.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .whenComplete(() {
    print("completed");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<CustomUser?>.value(
    return StreamProvider<CustomUser?>(
      // value: AuthService().user,
      create: (_) => AuthService().user,
      initialData: null,
      lazy: false,
      catchError: (_, __) => null,
      child: MaterialApp(
        home: const Wrapper(),
        theme: ThemeData(
          inputDecorationTheme: FilledOrOutlinedTextTheme(
            radius: 16,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            errorStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            fillColor: Colors.white,
            suffixIconColor: Colors.brown[100],
            prefixIconColor: Colors.brown[100],
          ),
        ),
      ),
    );
  }
}
