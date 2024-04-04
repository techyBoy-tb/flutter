import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media/components/heart.dart';
import 'package:media/components/movieCast.dart';
import 'package:media/model/CustomUser.dart';
import 'package:media/model/Movie.dart';
import 'package:media/secrets.dart';
import 'package:media/services/database.dart';
import 'package:media/utils/genre.dart';
import 'package:provider/provider.dart';

class MovieDetailsCard extends StatefulWidget {
  final MovieDetails movie;
  const MovieDetailsCard({super.key, required this.movie});

  @override
  State<MovieDetailsCard> createState() => _MovieDetailsCardState();
}

class _MovieDetailsCardState extends State<MovieDetailsCard> {
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 74),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: CupertinoTheme.of(context)
                .scaffoldBackgroundColor
                .withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              widget.movie.title,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 14),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.secondarySystemFill
                                  .resolveFrom(context),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: CupertinoColors.systemFill
                                  .resolveFrom(context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget sliverContactsSection(BuildContext context) {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       height: 132,
  //       padding: EdgeInsets.only(top: 12),
  //       child: ListView.builder(
  //         padding: EdgeInsets.all(10),
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           final person = people[index];
  //           return Container(
  //             width: 72,
  //             margin: EdgeInsets.symmetric(horizontal: 4),
  //             child: Column(
  //               children: <Widget>[
  //                 if (person.imageUrl != null)
  //                   Material(
  //                     child: CircleAvatar(
  //                       backgroundImage: AssetImage(
  //                         person.imageUrl!,
  //                       ),
  //                       radius: 30,
  //                       backgroundColor: Colors.white,
  //                     ),
  //                     shape: CircleBorder(),
  //                     elevation: 12,
  //                     shadowColor: Colors.black12,
  //                   ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   person.title,
  //                   maxLines: 2,
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(fontSize: 11),
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //         itemCount: people.length,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    DatabaseService databaseService = DatabaseService(uid: user.uid);
    final isMovieLiked =
        databaseService.isMovieFavourite(widget.movie.id.toString());

    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.transparent,
          // child: Scaffold(
          //   backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          //   extendBodyBehindAppBar: true,
          //   appBar: appBar(context),
          //   body: CustomScrollView(
          //     physics: ClampingScrollPhysics(),
          //     controller: ModalScrollController.of(context),
          //     slivers: <Widget>[
          //       SliverSafeArea(
          //         bottom: false,
          //         sliver: SliverToBoxAdapter(
          //           child: Container(
          //             height: 318,
          //             child: Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 6),
          //               child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(12),
          //                 child: Image.network(
          //                     '$imageUrl${widget.movie.posterPath}'),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       SliverToBoxAdapter(
          //         child: Divider(height: 1),
          //       ),
          //       // sliverContactsSection(context),
          //       SliverToBoxAdapter(
          //         child: Divider(height: 1),
          //       ),
          //       // SliverToBoxAdapter(
          //       //   child: Container(
          //       //     height: 120,
          //       //     padding: EdgeInsets.only(top: 12),
          //       //     child: ListView.builder(
          //       //       padding: EdgeInsets.all(10),
          //       //       scrollDirection: Axis.horizontal,
          //       //       itemBuilder: (context, index) {
          //       //         final app = apps[index];
          //       //         return Container(
          //       //           width: 72,
          //       //           margin: EdgeInsets.symmetric(horizontal: 4),
          //       //           child: Column(
          //       //             children: <Widget>[
          //       //               if (app.imageUrl != null)
          //       //                 Material(
          //       //                   child: ClipRRect(
          //       //                     child: Container(
          //       //                       height: 60,
          //       //                       width: 60,
          //       //                       decoration: BoxDecoration(
          //       //                           image: DecorationImage(
          //       //                               image: AssetImage(app.imageUrl!),
          //       //                               fit: BoxFit.cover),
          //       //                           color: Colors.white,
          //       //                           borderRadius:
          //       //                               BorderRadius.circular(15)),
          //       //                     ),
          //       //                   ),
          //       //                   shape: RoundedRectangleBorder(
          //       //                     borderRadius: BorderRadius.circular(15),
          //       //                   ),
          //       //                   elevation: 12,
          //       //                   shadowColor: Colors.black12,
          //       //                 ),
          //       //               SizedBox(height: 8),
          //       //               Text(
          //       //                 app.title,
          //       //                 maxLines: 2,
          //       //                 textAlign: TextAlign.center,
          //       //                 style: TextStyle(fontSize: 11),
          //       //               )
          //       //             ],
          //       //           ),
          //       //         );
          //       //       },
          //       //       itemCount: apps.length,
          //       //     ),
          //       //   ),
          //       // ),
          //       // SliverPadding(
          //       //   padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          //       //   sliver: SliverList(
          //       //     delegate: SliverChildListDelegate.fixed(
          //       //       List<Widget>.from(
          //       //         actions.map(
          //       //           (action) => Container(
          //       //             padding: EdgeInsets.symmetric(
          //       //                 vertical: 16, horizontal: 16),
          //       //             child: Text(
          //       //               action.title,
          //       //               style:
          //       //                   CupertinoTheme.of(context).textTheme.textStyle,
          //       //             ),
          //       //             decoration: BoxDecoration(
          //       //               borderRadius: BorderRadius.circular(8),
          //       //               color: CupertinoColors
          //       //                   .tertiarySystemGroupedBackground
          //       //                   .resolveFrom(context),
          //       //             ),
          //       //           ),
          //       //         ),
          //       //       ).addItemInBetween(
          //       //         Container(
          //       //           width: double.infinity,
          //       //           height: 1,
          //       //           color: CupertinoColors.separator.resolveFrom(context),
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       // SliverPadding(
          //       //   padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          //       //   sliver: SliverList(
          //       //     delegate: SliverChildListDelegate.fixed(
          //       //       List<Widget>.from(
          //       //         actions1.map(
          //       //           (action) => Container(
          //       //             padding: EdgeInsets.symmetric(
          //       //                 vertical: 16, horizontal: 16),
          //       //             child: Text(
          //       //               action.title,
          //       //               style:
          //       //                   CupertinoTheme.of(context).textTheme.textStyle,
          //       //             ),
          //       //             decoration: BoxDecoration(
          //       //               borderRadius: BorderRadius.only(
          //       //                 topLeft: action == actions1.first
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //                 topRight: action == actions1.first
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //                 bottomLeft: action == actions1.last
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //                 bottomRight: action == actions1.last
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //               ),
          //       //               color: CupertinoColors
          //       //                   .tertiarySystemGroupedBackground
          //       //                   .resolveFrom(context),
          //       //             ),
          //       //           ),
          //       //         ),
          //       //       ).addItemInBetween(
          //       //         Container(
          //       //           width: double.infinity,
          //       //           height: 1,
          //       //           color: CupertinoColors.separator.resolveFrom(context),
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       // SliverPadding(
          //       //   padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          //       //   sliver: SliverList(
          //       //     delegate: SliverChildListDelegate.fixed(
          //       //       List<Widget>.from(
          //       //         actions2.map(
          //       //           (action) => Container(
          //       //             padding: EdgeInsets.symmetric(
          //       //                 vertical: 16, horizontal: 16),
          //       //             child: Text(
          //       //               action.title,
          //       //               style:
          //       //                   CupertinoTheme.of(context).textTheme.textStyle,
          //       //             ),
          //       //             decoration: BoxDecoration(
          //       //               borderRadius: BorderRadius.only(
          //       //                 topLeft: action == actions2.first
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //                 topRight: action == actions2.first
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //                 bottomLeft: action == actions2.last
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //                 bottomRight: action == actions2.last
          //       //                     ? Radius.circular(8)
          //       //                     : Radius.zero,
          //       //               ),
          //       //               color: CupertinoColors
          //       //                   .tertiarySystemGroupedBackground
          //       //                   .resolveFrom(context),
          //       //             ),
          //       //           ),
          //       //         ),
          //       //       ).addItemInBetween(
          //       //         Container(
          //       //           width: double.infinity,
          //       //           height: 1,
          //       //           color: CupertinoColors.separator.resolveFrom(context),
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //       SliverSafeArea(
          //         top: false,
          //         sliver: SliverPadding(
          //           padding: EdgeInsets.only(
          //             bottom: 20,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  expandedHeight: MediaQuery.of(context).size.height / 2.1,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: '$imageUrl${widget.movie.posterPath}',
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
                                padding:
                                    const EdgeInsets.only(right: 10, top: 4),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 15)),
                          const SizedBox(height: 20),
                          MovieCastWidget(id: widget.movie.id, isTvShow: false),
                        ],
                      ));
                }, childCount: 1))
              ],
            ),
          ),
        ));
  }
}

extension ListUtils<T> on List<T> {
  List<T> addItemInBetween<A extends T>(A item) => isEmpty
      ? this
      : (fold([], (r, element) => [...r, element, item])..removeLast());
}

class SimpleSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SimpleSliverDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(height: height, child: child);
  }

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
