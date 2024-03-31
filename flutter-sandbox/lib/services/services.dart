import 'package:flutter_sandbox/model/Credit.dart';
import 'package:flutter_sandbox/model/Movie.dart';
import 'package:flutter_sandbox/model/PersonDetails.dart';
import 'package:flutter_sandbox/secrets.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
var key = '?api_key=$apiKey';
late String endPoint;

Future<MovieListResponse> getUpcomingMovies() async {
  endPoint = 'movie/upcoming';
  String params = '&language=en-GB&page=1';
  final String url = '$baseUrl$endPoint$key$params';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return movieListResponseFromJson(response.body);
  } else {
    throw Exception('Failed to load upcoming movies');
  }
}

Future<MovieListResponse> getPopularMovies() async {
  endPoint = 'movie/popular';
  String params = '&language=en-GB&page=1';
  final String url = '$baseUrl$endPoint$key$params';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return movieListResponseFromJson(response.body);
  } else {
    throw Exception('Failed to load upcoming movies');
  }
}

Future<Credit> getCredits(int id, bool isTvShow) async {
  endPoint = isTvShow ? 'tv/$id/credits' : 'movie/$id/credits';
  final String url = '$baseUrl$endPoint$key';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return creditFromJson(response.body);
  } else {
    throw Exception('Failed to load credits');
  }
}

Future<PersonDetails> getPersonDetails(int id) async {
  endPoint = 'person/$id';
  final String url = '$baseUrl$endPoint$key';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return personFromJson(response.body);
  } else {
    throw Exception('Failed to load person details');
  }
}

Future<MovieCredits> getMovieCredits(int personId) async {
  endPoint = 'person/$personId/movie_credits';
  String params = '&language=en-GB&page=1';
  final String url = '$baseUrl$endPoint$key$params';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return movieCreditsFromJson(response.body);
  } else {
    throw Exception('Failed to load upcoming movies');
  }
}
