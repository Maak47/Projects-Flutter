import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';

abstract class TripRepository {
  Future<TripEntity> getTrips();
  Future<void> addTrips(TripEntity tripEntity);
  Future<void> deleteTrips(int index);
}
