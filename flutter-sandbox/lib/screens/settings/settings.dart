import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/CustomUser.dart';
import 'package:flutter_sandbox/model/Movie.dart';
import 'package:flutter_sandbox/services/authService.dart';
import 'package:flutter_sandbox/services/databaseService.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _authService = AuthService();

  MovieDetails? foundMovie;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final DatabaseService databaseService = DatabaseService(uid: user.uid);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () => _authService.signOut(),
                child: const Text('Logout')),
            OutlinedButton(
                onPressed: () async {
                  Stream<List<MovieDetails>> resp = databaseService.movies;
                  List<MovieDetails> asd = await resp.first;
                  setState(() {
                    foundMovie = asd[0];
                  });
                },
                child: const Text('GET MOVIES')),
            Container(child: Text(foundMovie?.title ?? 'No movie found'))
          ],
        ),
      ),
    );
  }
}
