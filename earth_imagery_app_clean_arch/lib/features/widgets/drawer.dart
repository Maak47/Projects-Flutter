import 'package:earth_imagery_app/configs/constants/constants.dart';
import 'package:earth_imagery_app/features/pages/privacy_policy_page.dart';
import 'package:earth_imagery_app/features/pages/terms_conditions_page.dart';
import 'package:earth_imagery_app/helpers/appwrite_service.dart';
import 'package:flutter/material.dart';

class ThemedDrawer extends StatelessWidget {
  const ThemedDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kAccentColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Station\'s Corridor',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Where do you want to go?',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.policy_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books_outlined),
              title: const Text('Terms and Conditions'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TermsAndConditionsPage()));
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
