import 'package:earth_imagery_app/screens/currencyconv.dart';

import 'package:earth_imagery_app/screens/timeconv.dart';
import 'package:earth_imagery_app/widgets/bottomnav.dart';
import 'package:flutter/material.dart';

class EarthVisorDrawer extends StatelessWidget {
  final Function(int) onDrawerItemTap;

  const EarthVisorDrawer({super.key, required this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomLeft,
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 36, 28, 71),
            ),
            child: const Text(
              'EarthVisor',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BottomNav(
                          updateCurrentIndex: 0,
                        ))),
          ),
          ListTile(
            title: const Text('Impressions'),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BottomNav(
                          updateCurrentIndex: 1,
                        ))),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => BottomNav(
                        updateCurrentIndex: 2,
                      )),
            ),
          ),
          ListTile(
            title: const Text('Time Converter'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TimeConverter())),
          ),
          ListTile(
            title: const Text('Currency Converter'),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CurrencyConverter())),
          ),
        ],
      ),
    );
  }
}
