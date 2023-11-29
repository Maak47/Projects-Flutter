import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/trip_provider.dart';

class MyTripsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripList = ref.watch(tripListNotifierProvider);
    print('tripList : $tripList');

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tripList.length,
            itemBuilder: (context, index) {
              final trip = tripList[index];
              return Text(trip.title);
            },
          ),
        ],
      ),
    );
  }
}
