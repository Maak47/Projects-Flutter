import 'package:dartz/dartz.dart';
import 'package:travel_app_ca_riverpod_hive/core/error/failures.dart';
import 'package:travel_app_ca_riverpod_hive/features/trip/domain/entities/trip_entity.dart';

abstract class TripRepository {
  Future<Either<Failure, List<TripEntity>>> getTrips();
  Future<void> addTrip(TripEntity tripEntity);
  Future<void> deleteTrip(int index);
}
