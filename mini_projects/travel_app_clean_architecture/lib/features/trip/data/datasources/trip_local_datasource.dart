import '../models/trip.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TripLocalDataSource {
  final Box<Trip> tripBox;

  TripLocalDataSource(this.tripBox);

  List<Trip> getTrips() {
    return tripBox.values.toList();
  }

  addTrip(Trip trip) {
    tripBox.add(trip);
  }

  deleteTrip(int index) {
    tripBox.deleteAt(index);
  }
}
