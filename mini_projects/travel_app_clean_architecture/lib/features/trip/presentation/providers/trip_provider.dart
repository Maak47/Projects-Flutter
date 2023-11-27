import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_clean_architecture/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_clean_architecture/features/trip/data/models/trip.dart';
import 'package:travel_app_clean_architecture/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/usecases/add_trips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/usecases/delete_trips.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/usecases/get_trips.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<Trip> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository: repository);
});

final getTripsProvider = Provider<GetTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository: repository);
});

final deleteTripProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository: repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);
  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrips, this._addTrip, this._deleteTrip) : super([]);
  Future<void> addNewTrip(TripEntity tripEntity) async {
    await _addTrip(tripEntity);
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrip(tripId);
  }

  Future<void> loadTrips() async {
    await _getTrips();
  }
}
