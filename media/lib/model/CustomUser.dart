import 'package:media/model/Movie.dart';

class CustomUser {
  final String uid;

  CustomUser({required this.uid});
}

class UserData {
  final List<MovieDetails> movieList;
  final List<UserData> friendList;
  final String uid;
  final String name;

  UserData({
    required this.movieList,
    required this.friendList,
    required this.uid,
    required this.name,
  });
}
