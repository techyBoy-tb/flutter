import 'dart:convert';

ActorDetails personFromJson(String str) =>
    ActorDetails.fromJson(json.decode(str));

String personToJson(ActorDetails data) => json.encode(data.toJson());

class ActorDetails {
  final int id;
  final String imdbId;
  final String name;
  final bool adult;
  // final List<String> alsoKnownAs;
  final String bio;
  final String dateOfBirth;
  final String? dateOfDeath;
  final int gender;
  final double popularity;
  final String profileImage;
  final String birthPlace;

  ActorDetails({
    required this.id,
    required this.imdbId,
    required this.name,
    required this.adult,
    // required this.alsoKnownAs,
    required this.bio,
    required this.dateOfBirth,
    required this.dateOfDeath,
    required this.gender,
    required this.popularity,
    required this.profileImage,
    required this.birthPlace,
  });

  factory ActorDetails.fromJson(Map<String, dynamic> json) => ActorDetails(
        id: json["id"],
        imdbId: json['imdb_id'],
        name: json['name'],
        adult: json['adult'],
        // alsoKnownAs: json['also_known_as'],
        bio: json['biography'],
        dateOfBirth: json['birthday'],
        dateOfDeath: json['deathday'],
        gender: json['gender'],
        popularity: json['popularity'],
        profileImage: json['profile_path'],
        birthPlace: json['place_of_birth'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imdbId": imdbId,
        "name": name,
        "adult": adult,
        // "alsoKnownAs": alsoKnownAs,
        "bio": bio,
        "dateOfBirth": dateOfBirth,
        "dateOfDeath": dateOfDeath,
        "gender": gender,
        "popularity": popularity,
        "profileImage": profileImage,
        "birthPlace": birthPlace,
      };
}
