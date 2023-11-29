import '../repositories/trip_repository.dart';

class DeleteTrip {
  final TripRepository tripRepository;

  DeleteTrip(this.tripRepository);

  Future<void> call(int index) {
    return tripRepository.deleteTrip(index);
  }
}
