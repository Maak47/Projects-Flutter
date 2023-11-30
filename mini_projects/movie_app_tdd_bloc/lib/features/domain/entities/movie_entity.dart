class MovieEntity {
  final String title;
  final int id;

  final String overview;
  final String posterPath;

  MovieEntity(
      {required this.title,
      required this.id,
      required this.overview,
      required this.posterPath});
}
