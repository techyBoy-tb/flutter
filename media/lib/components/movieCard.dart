import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:media/components/movieDetailsCard.dart';
import 'package:media/model/Movie.dart';
import 'package:media/secrets.dart';
import 'package:media/utils/genre.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MovieCard extends StatefulWidget {
  final MovieDetails movie;
  final String tag;
  const MovieCard({super.key, required this.movie, required this.tag});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => MovieDetailsCard(movie: widget.movie),
        );
      },
      child: Stack(alignment: Alignment.bottomCenter, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: widget.tag,
            child: Image.network(
              '$imageUrl${widget.movie.posterPath}',
              width: 174.5,
              height: 300,
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
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    getGenres(widget.movie.genreIds ?? []),
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
  }
}
