import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/CustomUser.dart';
import 'package:flutter_sandbox/model/Movie.dart';
import 'package:flutter_sandbox/services/databaseService.dart';
import 'package:provider/provider.dart';

class User extends StatefulWidget {
  final UserData user;
  const User({super.key, required this.user});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  late Future<List<MovieDetails>> signedInUsersMovies;
  late Future<List<MovieDetails>> friendUsersMovies;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signedInUser = Provider.of<CustomUser>(context);
    final DatabaseService databaseService =
        DatabaseService(uid: signedInUser.uid);

    signedInUsersMovies = databaseService.getMoviesForUser(signedInUser.uid);
    friendUsersMovies = databaseService.getMoviesForUser(widget.user.uid);

    List<MovieDetails> getElementsAppearInBothList(
        List<MovieDetails> l1, List<MovieDetails> l2) {
      List<MovieDetails> commonMovies = [];
      for (var l1Element in l1) {
        for (var l2Element in l2) {
          if (l1Element.id == l2Element.id) {
            commonMovies.add(l1Element);
          }
        }
      }
      return commonMovies;
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            'User: ${widget.user.name}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          FutureBuilder(
              future: Future.wait([signedInUsersMovies, friendUsersMovies]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    List<MovieDetails> signedInMovies =
                        (snapshot.data![0] as List<MovieDetails>).toList();
                    List<MovieDetails> friendsMovies =
                        (snapshot.data![1] as List<MovieDetails>).toList();

                    bool userRequested = snapshot.data![2] as bool;

                    int numberOfMoviesInCommon = getElementsAppearInBothList(
                            signedInMovies, friendsMovies)
                        .length;

                    return Column(
                      children: [
                        Text(
                            '${widget.user.name} has liked ${friendsMovies.length} movies'),
                        Text(
                            'You both have ${numberOfMoviesInCommon} movies in common'),
                        const SizedBox(height: 15),
                      ],
                    );
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
              }),
        ],
      ),
    );
  }
}
