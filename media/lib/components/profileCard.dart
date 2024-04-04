import 'package:flutter/material.dart';
import 'package:media/model/CustomUser.dart';

class ProfileCard extends StatelessWidget {
  final UserData? user;
  const ProfileCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person_4_outlined),
              title: Text(user?.name ?? 'User not found'),
              subtitle: user == null
                  ? null
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${user?.movieList.length} movies liked"),
                        Text("${user?.friendList.length} friends"),
                      ],
                    ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     TextButton(
            //       child: const Text('BUY TICKETS'),
            //       onPressed: () {
            //         print('BUY TICKETS');
            //       },
            //     ),
            //     const SizedBox(width: 8),
            //     TextButton(
            //       child: const Text('LISTEN'),
            //       onPressed: () {
            //         print('LISTEN');
            //       },
            //     ),
            //     const SizedBox(width: 8),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
