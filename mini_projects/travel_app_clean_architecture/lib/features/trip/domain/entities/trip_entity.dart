class TripEntity {
  final String title;
  final List<String> photos;
  final String description;
  final DateTime date;
  final String location;

  TripEntity({
    required this.title,
    required this.photos,
    required this.description,
    required this.date,
    required this.location,
  });
}
