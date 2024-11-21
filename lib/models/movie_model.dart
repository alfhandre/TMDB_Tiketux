class MovieModel {
  final String? backdropPath;
  final int id;
  final String? name; // For TV shows
  final String? title; // For Movies
  final String overview;
  final String posterPath;
  final String? mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String? firstAirDate; // For TV shows
  final String? releaseDate; // For Movies
  final double voteAverage;
  final int voteCount;
  final List<String>? originCountry; // For TV shows

  MovieModel({
    this.backdropPath,
    required this.id,
    this.name,
    this.title,
    required this.overview,
    required this.posterPath,
    this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.firstAirDate,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.originCountry,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      name: json['name'] as String?,
      title: json['title'] as String?,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      mediaType: json['media_type'] as String?,
      adult: json['adult'] as bool,
      originalLanguage: json['original_language'] as String,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      firstAirDate: json['first_air_date'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] as int,
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'] ?? [])
          : null,
    );
  }
}
