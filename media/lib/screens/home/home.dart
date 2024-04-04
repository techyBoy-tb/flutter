import 'package:flutter/material.dart';
import 'package:media/components/carousel.dart';
import 'package:media/model/Movie.dart';
import 'package:media/services/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MovieListResponse> upcomingMovies;
  late Future<MovieListResponse> popularMovies;

  @override
  void initState() {
    upcomingMovies = getUpcomingMovies();
    popularMovies = getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        // Upcoming movies
        const Text('Upcoming movies'),
        FutureBuilder(
          future: upcomingMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                List<MovieDetails> upcomingMovieList = snapshot.data!.results;
                return SizedBox(
                    height: 300,
                    child: Carousel(
                        movieList: upcomingMovieList, type: 'upcoming'));
              } else {
                return const Text('There was an error');
              }
            } else if (snapshot.hasError) {
              throw Exception(snapshot.error);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),

        const Text('Popular movies'),
        FutureBuilder(
          future: popularMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                List<MovieDetails> popularMovieList = snapshot.data!.results;
                return SizedBox(
                    height: 300,
                    child:
                        Carousel(movieList: popularMovieList, type: 'popular'));
              } else {
                return const Text('There was an error');
              }
            } else if (snapshot.hasError) {
              throw Exception(snapshot.error);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    ));
  }
}
