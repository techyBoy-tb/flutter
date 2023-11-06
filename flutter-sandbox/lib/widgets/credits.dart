import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/Movie.dart';
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
              var data = snapshot.data!.movies;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Movie credits',
                      style: Theme.of(context).textTheme.titleLarge),
                  AspectRatio(
                      aspectRatio: 2.1,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: data.length > 20 ? 10 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 50,
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  title: Text('Melbourne Cricket Stadium'),
                                  subtitle: Text('Australia'),
                                ),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      )
                      // child: ListView.builder(
                      //   shrinkWrap: true,
                      //   // I am setting the max to 20!
                      //   itemCount: data.length > 20 ? 10 : data.length,
                      //   itemBuilder: (context, index) {
                      //     return GestureDetector(
                      //         onTap: () {
                      //           // Navigator.push(
                      //           //     context,
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) => Person(
                      //           //             personId: data[index]!.id ?? 0)));
                      //         },
                      //         // child: Padding(
                      //         //     padding: const EdgeInsets.all(5),
                      //         //     child: Column(
                      //         //       mainAxisAlignment:
                      //         //           MainAxisAlignment.spaceEvenly,
                      //         //       children: [
                      //         //         CircleAvatar(
                      //         //           backgroundColor: Colors.grey,
                      //         //           radius: 40,
                      //         //           child: ClipOval(
                      //         //               child: Hero(
                      //         //             tag:
                      //         //                 '$imageUrl${data[index].posterPath}',
                      //         //             child: FadeInImage(
                      //         //               width: double.infinity,
                      //         //               fit: BoxFit.cover,
                      //         //               image: NetworkImage(
                      //         //                   '$imageUrl${data[index].posterPath}'),
                      //         //               placeholder: const NetworkImage(
                      //         //                   'http://www.familylore.org/images/2/25/UnknownPerson.png'),
                      //         //               imageErrorBuilder:
                      //         //                   (context, error, stackTrace) {
                      //         //                 return Image.network(
                      //         //                     'http://www.familylore.org/images/2/25/UnknownPerson.png');
                      //         //               },
                      //         //             ),
                      //         //           )),
                      //         //         ),
                      //         //         SizedBox(
                      //         //             width: 100,
                      //         //             child: Text(
                      //         //               data[index].title!,
                      //         //               textAlign: TextAlign.center,
                      //         //             )),
                      //         //       ],
                      //         //     )),
                      //   },
                      // )),
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
