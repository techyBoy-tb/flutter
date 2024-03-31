import 'package:flutter_sandbox/model/Movie.dart';

class CustomUser {
  final String uid;

  CustomUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;

  UserData({
    required this.uid,
    required this.name,
  });
}

class Friend extends UserData {
  final List<MovieDetails> movieList;

  Friend({
    required this.movieList,
    required super.uid,
    required super.name,
  });
}
