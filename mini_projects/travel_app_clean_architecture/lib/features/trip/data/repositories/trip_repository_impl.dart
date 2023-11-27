import 'package:travel_app_clean_architecture/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_clean_architecture/features/trip/data/models/trip.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(this.localDataSource);
  @override
  Future<void> addTrips(TripEntity tripEntity) async {
    final Trip trip = Trip.fromEntity(tripEntity);
    localDataSource.addTrip(trip);
  }

  @override
  Future<void> deleteTrips(int index) async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<List<TripEntity>> getTrips() async {
    final trips = localDataSource.getTrips();
    List<TripEntity> res = trips.map((e) => e.toEntity()).toList();
    return res;
  }
}
