import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: true),
        textTheme: GoogleFonts.latoTextTheme(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 36, 28, 71)),
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
            brightness: Brightness.dark,
            background: Color.fromARGB(255, 36, 28, 71)
            // primarySwatch: Colors.purple,
            // accentColor: Color.fromARGB(255, 84, 59, 130),
            ),
      ),
      home: const BottomNav(),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EarthVisorDrawer(
        onDrawerItemTap: (page) {
          // Handle navigation to each page
          // Implement the navigation logic based on the selected page
          print('Navigating to $page');
        },
      ),
      bottomNavigationBar: ClipRect(
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.rate_review_rounded), label: 'Impressions'),
            NavigationDestination(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          elevation: 5,
          selectedIndex: currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      body: [
        const Home(),
        const Impressions(),
        const Profile(),
      ][currentIndex],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Impressions extends StatelessWidget {
  const Impressions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'User Profile',
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.login_rounded)),
          ]),
      drawer: EarthVisorDrawer(
        onDrawerItemTap: (page) {
          // Handle navigation to each page
          // Implement the navigation logic based on the selected page
          print('Navigating to $page');
          Navigator.pop(context); // Close the drawer after selection
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            const CircleAvatar(
              radius: 103,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/profpic.jpg'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Rahmawati Dwi Augustin',
              style: textStyle(25),
            ),
            Text(
              '124210046 | PAM SI-C',
              style: textStyle(20),
            ),
            Text(
              'Bontang, 30th August 2003',
              style: textStyle(17),
            ),
            Text(
              'Hobby: Procrastinating',
              style: textStyle(20),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )),
      ),
    );
  }

  TextStyle textStyle(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }
}

class EarthVisorDrawer extends StatelessWidget {
  final Function(String) onDrawerItemTap;

  EarthVisorDrawer({super.key, required this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'EarthVisor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => onDrawerItemTap('Home'),
          ),
          ListTile(
            title: const Text('Impressions'),
            onTap: () => onDrawerItemTap('Impressions'),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () => onDrawerItemTap('Profile'),
          ),
          ListTile(
            title: const Text('Time Converter'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TimeConverter())),
          ),
          ListTile(
            title: const Text('Currency Converter'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CurrencyConverter())),
          ),
        ],
      ),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  late TextEditingController _amountController;
  String? _convertFromCurrency;
  String? _convert2Currency;
  double _convertedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  void _convertCurrency() {
    setState(() {
      double amount = double.tryParse(_amountController.text) ?? 0.0;
      // Implement your currency conversion logic here
      // For simplicity, let's just double the amount as an example
      if (_convert2Currency == 'USD' && _convertFromCurrency == 'USD' ||
          _convert2Currency == 'IDR' && _convertFromCurrency == 'IDR' ||
          _convert2Currency == 'GBP' && _convertFromCurrency == 'GBP' ||
          _convert2Currency == 'EUR' && _convertFromCurrency == 'EUR' ||
          _convert2Currency == 'JPY' && _convertFromCurrency == 'JPY' ||
          _convert2Currency == '' && _convertFromCurrency == '') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(
              255,
              251,
              235,
              247,
            ),
            content: Text(
              'Set different options for conversion',
              // style: TextStyle(color: Colors.white),
            )));
        return;
      }

      Map<String, double> conversionRates = {
        'USD_IDR': 15540.00,
        'USD_EUR': 0.91,
        'USD_GBP': 0.79,
        'USD_JPY': 149.57,
        'IDR_USD': 0.000064,
        'IDR_EUR': 0.000059,
        'IDR_GBP': 0.000051,
        'IDR_JPY': 0.0096,
        'EUR_USD': 1.10,
        'EUR_GBP': 0.87,
        'EUR_JPY': 131.25,
        'EUR_IDR': 16977.21,
        'GBP_USD': 1.27,
        'GBP_EUR': 1.15,
        'GBP_JPY': 150.80,
        'GBP_IDR': 19576.27,
        'JPY_USD': 0.0067,
        'JPY_EUR': 0.0076,
        'JPY_GBP': 0.0066,
        'JPY_IDR': 103.81,
      };

      String currencyPair = '$_convertFromCurrency' '_' '$_convert2Currency';

      if (conversionRates.containsKey(currencyPair)) {
        _convertedAmount = amount * conversionRates[currencyPair]!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/money.png'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _convertFromCurrency,
                    onChanged: (String? value) {
                      setState(() {
                        _convertFromCurrency = value!;
                      });
                    },
                    items: [
                      'IDR',
                      'USD',
                      'EUR',
                      'GBP',
                      'JPY'
                    ] // Add more currencies as needed
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Colors
                                  .white), // Dropdown item text color in white
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      style: const TextStyle(
                          color: Colors.white), // Text color in white
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20),
                        prefixIconColor: Colors.white,

                        labelText: 'Enter Amount',
                        labelStyle: TextStyle(
                            color: Colors.white), // Label color in white
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _convert2Currency,
                onChanged: (String? value) {
                  setState(() {
                    _convert2Currency = value!;
                  });
                },
                items: [
                  'IDR',
                  'USD',
                  'EUR',
                  'GBP',
                  'JPY'
                ] // Add more currencies as needed
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors
                              .white), // Dropdown item text color in white
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 209, 180, 228)),
                onPressed: _convertCurrency,
                child: const Text(
                  'Convert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white), // Button text color in white
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Converted Amount: $_convertedAmount',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Converted amount text color in white
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
