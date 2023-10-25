import 'package:firebase/models/Brew.dart';
import 'package:firebase/screens/home/brew_list.dart';
import 'package:firebase/screens/home/settings_form.dart';
import 'package:firebase/services/authService.dart';
import 'package:firebase/services/databaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  final _fabKey = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    void toggleShowBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const SettingsForm(),
            );
          });
    }

    void toggleDeleteModal() {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    'Are you sure?',
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Are you sure you want to delete your coffee order? Once you do this, it cannot be undone!',
                    style: TextStyle(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _fabKey.currentState?.toggle();
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _fabKey.currentState?.toggle();
                          },
                          child: const Text('Delete'))
                    ],
                  )
                ],
              ),
            );
          });
    }

    // final user = Provider.of<CustomUser>(context);

    return StreamProvider<List<Brew>?>(
      initialData: null,
      create: (_) => DatabaseService(uid: 'user.uid').brews,
      catchError: (_, __) {},
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            OutlinedButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover)),
          child: const BrewList(),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          key: _fabKey,
          type: ExpandableFabType.up,
          children: [
            FloatingActionButton.extended(
              onPressed: () => toggleShowBottomSheet(),
              backgroundColor: Colors.brown[400],
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              // child: const Icon(Icons.edit),
            ),
            FloatingActionButton.extended(
                // Toggle delete modal!
                onPressed: () => toggleDeleteModal(),
                backgroundColor: Colors.red[400],
                label: const Text('Delete'),
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
