import 'dart:convert';

MovieDetails movieFromJson(String str) =>
    MovieDetails.fromJson(json.decode(str));

String movieToJson(MovieDetails data) => json.encode(data.toJson());

MovieListResponse movieListResponseFromJson(String str) =>
    MovieListResponse.fromJson(json.decode(str));

String movieListResponseToJson(MovieListResponse data) =>
    json.encode(data.toJson());

MovieCredits movieCreditsFromJson(String str) =>
    MovieCredits.fromJson(json.decode(str));

String movieCreditsToJson(MovieCredits data) => json.encode(data.toJson());

class MovieDetails {
  bool adult;
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  List<int> genreIds;
  double popularity;
  DateTime? releaseDate;
  bool video;
  double averageVote;
  int numberOfVotes;

  MovieDetails({
    required this.adult,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.averageVote,
    required this.numberOfVotes,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        adult: json['adult'],
        id: json['id'],
        title: json['title'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json['popularity'].toDouble(),
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        video: json['video'],
        averageVote: json['vote_average'].toDouble(),
        numberOfVotes: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'id': id,
        'title': title,
        'originalTitle': originalTitle,
        'overview': overview,
        'posterPath': posterPath,
        'genreIds': List<dynamic>.from(genreIds!.map((x) => x)),
        'popularity': popularity,
        'releaseDate': releaseDate == null
            ? null
            : "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        'video': video,
        'averageVote': averageVote,
        'numberOfVotes': numberOfVotes,
      };
}

class MovieListResponse {
  int? page;
  List<MovieDetails> results;
  int? totalPages;
  int? totalResults;

  MovieListResponse({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      MovieListResponse(
        page: json["page"],
        results: List<MovieDetails>.from(
            json["results"].map((x) => MovieDetails.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class StarredMovie extends MovieDetails {
  String creditId;
  String character;

  StarredMovie(
      {required this.creditId,
      required this.character,
      required super.adult,
      required super.id,
      required super.title,
      required super.originalTitle,
      required super.overview,
      required super.posterPath,
      required super.genreIds,
      required super.popularity,
      super.releaseDate,
      required super.video,
      required super.averageVote,
      required super.numberOfVotes});

  factory StarredMovie.fromJson(Map<String, dynamic> json) => StarredMovie(
        character: json['character'],
        creditId: json['credit_id'],
        adult: json['adult'],
        id: json['id'],
        title: json['title'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'] ??
            'http://www.familylore.org/images/2/25/UnknownPerson.png',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json['popularity'].toDouble(),
        releaseDate: json["release_date"] == null || json["release_date"] == ''
            ? null
            : DateTime.parse(json["release_date"]),
        video: json['video'],
        averageVote: json['vote_average'].toDouble(),
        numberOfVotes: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'character': character,
        'creditId': creditId,
        'adult': adult,
        'id': id,
        'title': title,
        'originalTitle': originalTitle,
        'overview': overview,
        'posterPath': posterPath,
        'genreIds': List<dynamic>.from(genreIds!.map((x) => x)),
        'popularity': popularity,
        'releaseDate': releaseDate == null
            ? null
            : "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        'video': video,
        'averageVote': averageVote,
        'numberOfVotes': numberOfVotes,
      };
}

class MovieCredits {
  List<StarredMovie> movies;

  MovieCredits({required this.movies});

  factory MovieCredits.fromJson(Map<String, dynamic> json) => MovieCredits(
        movies: List<StarredMovie>.from(
            json["cast"].map((x) => StarredMovie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}
