import 'package:flutter/material.dart';
import 'package:media/components/profileCard.dart';
import 'package:media/model/CustomUser.dart';
import 'package:media/services/auth.dart';
import 'package:media/services/database.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    DatabaseService dbService = DatabaseService(uid: user.uid);
    Future<UserData> foundUser = dbService.getUserById(user.uid);

    Future<void> dialogBuilder(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'By logging out you will not be able to see what movies your friends have liked.\n'
              'Any movies that you like will not be linked to your profile',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Logout'),
                onPressed: () {
                  _authService.signOut();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return SafeArea(
      child: Column(
        children: [
          FutureBuilder(
              future: foundUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ProfileCard(user: snapshot.data);
                  }
                }
                return const Text('No user found');
              }),
          ElevatedButton(
              onPressed: () => dialogBuilder(context),
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
