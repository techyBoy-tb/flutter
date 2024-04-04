import 'package:flutter/material.dart';
import 'package:media/model/Credit.dart';
import 'package:media/secrets.dart';
import 'package:media/services/movie.dart';

class MovieCastWidget extends StatefulWidget {
  final int id;
  final bool isTvShow;
  const MovieCastWidget({super.key, required this.id, required this.isTvShow});

  @override
  State<MovieCastWidget> createState() => _MovieCastWidgetState();
}

class _MovieCastWidgetState extends State<MovieCastWidget> {
  late Future<Credit> creditsFuture;
  @override
  void initState() {
    creditsFuture = getCredits(widget.id, widget.isTvShow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: creditsFuture,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            var data = snapshot.data?.cast;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cast', style: Theme.of(context).textTheme.titleLarge),
                AspectRatio(
                    aspectRatio: 2.1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // I am setting the max to 20!
                      itemCount: data!.length > 20 ? 10 : data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Person(
                          //               personId: data[index]!.id ?? 0)));
                          // },
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 40,
                                    child: ClipOval(
                                        child: Hero(
                                      tag:
                                          '$imageUrl${data[index].profilePath}',
                                      child: FadeInImage(
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '$imageUrl${data[index].profilePath}'),
                                        placeholder: const NetworkImage(
                                            'http://www.familylore.org/images/2/25/UnknownPerson.png'),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                              'http://www.familylore.org/images/2/25/UnknownPerson.png');
                                        },
                                      ),
                                    )),
                                  ),
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        data[index].name!,
                                        textAlign: TextAlign.center,
                                      )),
                                ],
                              )),
                        );
                      },
                    )),
              ],
            );
          } else if (snapshot.hasError) {
            throw snapshot.error.toString();
          } else {
            return const SizedBox();
          }
        });
  }
}
