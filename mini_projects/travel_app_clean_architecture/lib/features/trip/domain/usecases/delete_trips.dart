import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class DeleteTrips {
  final TripRepository repository;

  DeleteTrips({required this.repository});

  Future<void> call(int index) {
    return repository.deleteTrips(index);
  }
}
