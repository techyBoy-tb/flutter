import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media/model/CustomUser.dart';
import 'package:media/model/Movie.dart';

class DatabaseService {
  late String uid;
  DatabaseService({required this.uid});

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  /// MOVIES
  Future<void> addMovieToFavourites(MovieDetails movie) async {
    return await collection
        .doc(uid)
        .collection('movies')
        .doc(movie.id.toString())
        .set({
      "adult": movie.adult,
      "id": movie.id,
      "title": movie.title,
      "originalTitle": movie.originalTitle,
      "overview": movie.overview,
      "posterPath": movie.posterPath,
      "genreIds": movie.genreIds,
      "popularity": movie.popularity,
      "releaseDate": movie.releaseDate!.toIso8601String(),
      "video": movie.video,
      "averageVote": movie.averageVote,
      "numberOfVotes": movie.numberOfVotes,
    });
  }

  Future<bool> isMovieFavourite(String movieId) async {
    DocumentSnapshot documentRef =
        await collection.doc(uid).collection('movies').doc(movieId).get();

    return documentRef.exists;
  }

  Future<void> removeMovieFromFavourites(String movieId) async {
    return await collection.doc(uid).collection('movies').doc(movieId).delete();
  }

  List<MovieDetails> _movieListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map data = jsonDecode(jsonEncode(doc.data()));

      List<int> genreIds =
          List<int>.from(data['genreIds'].map((item) => item as int));

      MovieDetails movie = MovieDetails(
          adult: data['adult'],
          id: data['id'],
          title: data['title'],
          originalTitle: data['originalTitle'],
          overview: data['overview'],
          posterPath: data['posterPath'],
          genreIds: genreIds,
          popularity: data['popularity'],
          video: data['video'],
          averageVote: data['averageVote'],
          numberOfVotes: data['numberOfVotes']);
      return movie;
    }).toList();
  }

  Stream<List<MovieDetails>> get movies {
    return collection
        .doc(uid)
        .collection('movies')
        .snapshots()
        .map(_movieListFromSnapshot);
  }

  Future<List<MovieDetails>> getMoviesForUser(String userId) async {
    return await collection
        .doc(userId)
        .collection('movies')
        .snapshots()
        .map(_movieListFromSnapshot)
        .first;
  }

  /// USERS
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          uid: doc.id,
          name: jsonDecode(jsonEncode(doc.data()))['name'],
          movieList: [],
          friendList: []);
    }).toList();
  }

  Stream<List<UserData>> get userList {
    return collection.snapshots().map(_userListFromSnapshot);
  }

  Future<void> updateUserList(String userId, String name) async {
    return await collection.doc(uid).set({"name": name});
  }

  Future<UserData> getUserById(String userId) async {
    DocumentSnapshot documentSnapshot =
        await collection.doc(userId).snapshots().first;
    Map data = jsonDecode(jsonEncode(documentSnapshot.data()));

    return UserData(
        uid: userId, name: data['name'], movieList: [], friendList: []);
  }
}
