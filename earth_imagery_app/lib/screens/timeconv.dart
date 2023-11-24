import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeConverter extends StatefulWidget {
  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  late DateTime _currentTime;
  late String selectedTimeZone;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    selectedTimeZone = 'UTC';
  }

  Future<void> _updateTime() async {
    // Update the time without using the timezone package
    DateTime now = DateTime.now();
    _convertTime(selectedTimeZone, now);
  }

  void _convertTime(String timeZone, DateTime time) {
    // Convert the time to the selected time zone

    setState(() {
      _currentTime =
          time.toUtc().add(Duration(hours: _getTimeZoneOffset(timeZone)));
    });
  }

  int _getTimeZoneOffset(String timeZone) {
    // Get the time zone offset in hours
    switch (timeZone) {
      case 'UTC':
        return 0;
      case 'America/New_York':
        return -5;
      case 'Europe/London':
        return 0;
      case 'Asia/Tokyo':
        return 9;
      // Add more time zones as needed
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/time.png'),
            ElevatedButton(
              onPressed: () => _updateTime(),
              child: Text(
                'Update Time',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              dropdownColor: Color.fromARGB(255, 88, 73, 127),
              value: selectedTimeZone,
              onChanged: (String? value) {
                setState(() {
                  selectedTimeZone = value!;
                  // _convertTime(selectedTimeZone, _currentTime);
                });
              },
              items: [
                'UTC',
                'America/New_York',
                'Europe/London',
                'Asia/Tokyo',
                // Add more time zones as needed
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Time: ${DateFormat.Hm().format(_currentTime)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
