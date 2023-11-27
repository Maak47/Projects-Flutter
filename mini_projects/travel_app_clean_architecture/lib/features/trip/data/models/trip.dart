import 'package:hive/hive.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';

part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<String> photos;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String location;

  Trip({
    required this.title,
    required this.photos,
    required this.description,
    required this.date,
    required this.location,
  });

//Conversion from Entity to Model
  factory Trip.fromEntity(TripEntity tripEntity) => Trip(
        title: tripEntity.title,
        photos: tripEntity.photos,
        description: tripEntity.description,
        date: tripEntity.date,
        location: tripEntity.location,
      );

  TripEntity toEntity() => TripEntity(
        title: title,
        photos: photos,
        description: description,
        date: date,
        location: location,
      );
}
