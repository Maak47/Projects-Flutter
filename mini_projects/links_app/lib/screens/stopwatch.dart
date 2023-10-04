import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int milliseconds = 0;
  bool isRunning = false;
  late Timer timer;

  @override
  void initState() {
    timer = Timer(Duration.zero, () {});
    super.initState();
  }

  void _startStopwatch() {
    setState(() {
      if (isRunning) {
        // Stop the stopwatch and cancel the timer
        isRunning = false;
        timer.cancel();
      } else {
        // Start the stopwatch and create a new timer
        isRunning = true;
        timer = Timer.periodic(Duration(milliseconds: 100), _updateTime);
      }
    });
  }

  void _resetStopwatch() {
    setState(() {
      // Reset the stopwatch and cancel the timer
      milliseconds = 0;
      isRunning = false;
      timer.cancel();
    });
  }

  void _updateTime(Timer timer) {
    setState(() {
      milliseconds += 100;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _formatMilliseconds(int milliseconds) {
    final int seconds = (milliseconds / 1000).floor();
    final int minutes = (seconds / 60).floor();
    final int hours = (minutes / 60).floor();

    final int remainingSeconds = seconds % 60;
    final int remainingMinutes = minutes % 60;

    final String hoursStr = hours.toString().padLeft(2, '0');
    final String minutesStr = remainingMinutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    final String millisecondsStr =
        (milliseconds % 1000).toString().padLeft(3, '0');

    return '$hoursStr:$minutesStr:$secondsStr.$millisecondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatMilliseconds(milliseconds),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text(isRunning ? 'Stop' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
