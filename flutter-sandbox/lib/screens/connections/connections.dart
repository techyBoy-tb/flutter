import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/CustomUser.dart';
import 'package:flutter_sandbox/screens/connections/invite.dart';
import 'package:flutter_sandbox/services/databaseService.dart';
import 'package:provider/provider.dart';

class Connections extends StatefulWidget {
  const Connections({super.key});

  @override
  State<Connections> createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  late Future<List<Friend>> friendList;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    DatabaseService databaseService = DatabaseService(uid: user.uid);
    friendList = databaseService.getFriendList();

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Connections',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return const Dialog(child: InviteFriend());
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: friendList,
                  builder: (build, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        if (snapshot.data!.isNotEmpty) {
                          return const Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(children: []));
                        } else {
                          return Wrap(
                            children: [
                              Text('Seems you have no friends...',
                                  style:
                                      Theme.of(context).textTheme.titleMedium)
                            ],
                          );
                        }
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2.5),
                          child: const Center(
                            child: Text('THERE WAS AN ERROR'),
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      throw Exception(snapshot.error);
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
