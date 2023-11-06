import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/Movie.dart';
import 'package:flutter_sandbox/screens/details.dart';
import 'package:flutter_sandbox/secrets.dart';
import 'package:flutter_sandbox/services/services.dart';
import 'package:flutter_sandbox/utils/genre.dart';
import 'package:flutter_sandbox/widgets/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<MovieListResponse> upcomingMovies;

  @override
  void initState() {
    upcomingMovies = getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text('Home screen', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        FutureBuilder(
            future: upcomingMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  List<MovieDetails> myList = snapshot.data!.results;
                  return MyCarouselSlider(
                    itemCount: myList.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(movie: myList[index])));
                        },
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                              tag: '$imageUrl${myList[index].posterPath}',
                              child: Image.network(
                                '$imageUrl${myList[index].posterPath}',
                                width: 174.5,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 60,
                                width: 175,
                                padding: const EdgeInsets.all(10),
                                color: Colors.black26,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myList[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      getGenres(myList[index].genreIds ?? []),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
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
    );
  }
}
