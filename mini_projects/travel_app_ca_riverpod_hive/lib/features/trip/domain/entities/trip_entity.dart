class TripEntity {
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final List<String> photos;

  TripEntity(
      {required this.title,
      required this.description,
      required this.location,
      required this.date,
      required this.photos});
}
