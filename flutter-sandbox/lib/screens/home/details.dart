import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/CustomUser.dart';
import 'package:flutter_sandbox/model/Movie.dart';
import 'package:flutter_sandbox/secrets.dart';
import 'package:flutter_sandbox/services/databaseService.dart';
import 'package:flutter_sandbox/shared/heart.dart';
import 'package:flutter_sandbox/utils/genre.dart';
import 'package:flutter_sandbox/widgets/cast.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final MovieDetails movie;
  final String? tag;

  const Details({super.key, required this.movie, this.tag});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final DatabaseService databaseService = DatabaseService(uid: user.uid);
    final isMovieLiked =
        databaseService.isMovieFavourite(widget.movie.id.toString());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: MediaQuery.of(context).size.height / 2.1,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.tag ?? '$imageUrl${widget.movie.posterPath}',
                child: Image.network(
                  '$imageUrl${widget.movie.posterPath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: const Center(child: Text('No Image')),
                    );
                  },
                ),
              ),
            ),
            actions: [
              Heart(
                  initialValue: isMovieLiked,
                  onPress: (newVal) {
                    if (newVal) {
                      databaseService.addMovieToFavourites(widget.movie);
                    } else {
                      databaseService.removeMovieFromFavourites(
                          widget.movie.id.toString());
                    }
                  })
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, _) {
            return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.movie.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    Wrap(
                      children: List.generate(
                        widget.movie.genreIds.length,
                        (genreIndex) => Padding(
                          padding: const EdgeInsets.only(right: 10, top: 4),
                          child: Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(width: 0),
                            ),
                            label: Text(getGenres(widget.movie.genreIds)
                                .split(',')
                                .elementAt(genreIndex)),
                          ),
                        ),
                        growable: false,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.date_range),
                          Text(widget.movie.releaseDate
                              .toString()
                              .substring(0, 4)),
                          const SizedBox(width: 10),
                          const Icon(Icons.star),
                          Text(widget.movie.averageVote.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Story line',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 15),
                    Text(widget.movie.overview,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 15)),
                    const SizedBox(height: 20),
                    CastWidget(id: widget.movie.id, isTvShow: false),
                  ],
                ));
          }, childCount: 1))
        ],
      ),
    );
  }
}
