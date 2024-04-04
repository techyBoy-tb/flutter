import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:media/model/CustomUser.dart';
import 'package:media/screens/wrapper.dart';
import 'package:media/services/auth.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'theme/colourScheme.dart';
import 'theme/typography.dart';

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
        create: (_) => AuthService().user,
        initialData: null,
        lazy: false,
        catchError: (_, __) => null,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: textTheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: textTheme,
          ),
          home: const Wrapper(),
        ));
  }
}
