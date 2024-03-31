import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/Movie.dart';
import 'package:flutter_sandbox/screens/home/details.dart';
import 'package:flutter_sandbox/secrets.dart';
import 'package:flutter_sandbox/services/services.dart';

class Credits extends StatefulWidget {
  final int id;
  final bool isTvShow;

  const Credits({super.key, required this.id, required this.isTvShow});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  late Future<MovieCredits> creditsFuture;

  @override
  void initState() {
    creditsFuture = getMovieCredits(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: creditsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var data = [];
              var unreleasedMovies = [];
              for (var element in snapshot.data!.movies) {
                if (element.releaseDate != null) {
                  data.add(element);
                } else {
                  unreleasedMovies.add(element);
                }
              }

              data.sort((a, b) => (b.releaseDate ?? DateTime.now())
                  .compareTo(a.releaseDate ?? DateTime.now()));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Movie credits',
                      style: Theme.of(context).textTheme.titleLarge),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: List.generate(
                            data.length,
                            (creditIndex) {
                              StarredMovie currentMovie = data[creditIndex];

                              String releaseDate =
                                  currentMovie.releaseDate != null
                                      ? currentMovie.releaseDate
                                          .toString()
                                          .substring(0, 4)
                                      : 'Coming soon...';

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Details(movie: currentMovie)));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Hero(
                                              tag:
                                                  '$imageUrl${currentMovie.posterPath}',
                                              child: Image.network(
                                                  '$imageUrl${currentMovie.posterPath}',
                                                  height: 150,
// width: 200,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                return Container(
                                                  color: Colors.grey,
                                                  height: 150,
                                                  child: Center(
                                                    child: Transform.rotate(
                                                      angle: pi / 4,
                                                      child: const Text(
                                                          'Coming soon...',
                                                          style: TextStyle()),
                                                    ),
                                                  ),
                                                );
                                              })),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(currentMovie.title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                              const SizedBox(height: 10),
                                              Text(releaseDate),
                                              const SizedBox(height: 10),
                                              Text(currentMovie.character,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              );
                            },
                            growable: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text('No data to display'),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text('There was an error'),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
