import 'dart:ui';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/PersonDetails.dart';
import 'package:flutter_sandbox/secrets.dart';
import 'package:flutter_sandbox/services/services.dart';
import 'package:flutter_sandbox/widgets/credits.dart';

class Person extends StatefulWidget {
  final int personId;
  const Person({super.key, required this.personId});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  late Future<PersonDetails> foundPerson;

  @override
  void initState() {
    foundPerson = getPersonDetails(widget.personId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: foundPerson,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: MediaQuery.of(context).size.height / 2.1,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                            tag: '$imageUrl${snapshot.data?.profileImage}',
                            child: Image.network(
                                '$imageUrl${snapshot.data?.profileImage}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey,
                                child: const Center(child: Text('No Image')),
                              );
                            })),
                        title: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              color: Colors.black26,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.name,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, _) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text('About',
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 15),
                            ExpandableText(
                              snapshot.data!.bio,
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 5,
                              linkColor: Colors.blue,
                            ),
                            // Text(snapshot.data!.bio,
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyMedium!
                            //         .copyWith(
                            //             color: Colors.white.withOpacity(0.9),
                            //             fontSize: 15)),
                            const SizedBox(height: 20),
                            Credits(id: snapshot.data!.id, isTvShow: false),
                          ],
                        ),
                      );
                    }, childCount: 1))
                  ],
                ),
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
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
