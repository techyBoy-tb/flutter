import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:media/components/movieCard.dart';
import 'package:media/model/Movie.dart';
import 'package:media/secrets.dart';

class Carousel extends StatefulWidget {
  final List<MovieDetails> movieList;
  final String type;
  const Carousel({super.key, required this.movieList, required this.type});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late InfiniteScrollController controller;
  // Maintain current index of carousel
  int _selectedIndex = 0;
  // Width of each item
  double _itemExtent = 120;
  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    controller = InfiniteScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 200;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      itemCount: widget.movieList.length,
      itemExtent: _itemExtent ?? 40,
      center: true,
      anchor: 0.0,
      velocityFactor: 0.5,
      controller: controller,
      axisDirection: Axis.horizontal,
      loop: true,
      itemBuilder: (context, itemIndex, realIndex) {
        final currentOffset = _itemExtent * realIndex;
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final diff = (controller.offset - currentOffset);
            const maxPadding = 10.0;
            final carouselRatio = _itemExtent / maxPadding;

            return Padding(
              padding: EdgeInsets.only(
                top: (diff / carouselRatio).abs(),
                bottom: (diff / carouselRatio).abs(),
              ),
              child: child,
            );
          },
          child: MovieCard(
              movie: widget.movieList[itemIndex],
              tag:
                  '${widget.type}-$imageUrl${widget.movieList[itemIndex].posterPath}'),
        );
      },
    );
  }
}
