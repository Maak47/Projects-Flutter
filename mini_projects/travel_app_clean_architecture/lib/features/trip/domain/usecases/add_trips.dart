import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip({required this.repository});

  Future<void> call(TripEntity tripEntity) {
    return repository.addTrips(tripEntity);
  }
}
