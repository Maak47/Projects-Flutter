import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '''
1. Information Collection
   We may collect personal information such as your name, email address, and usage data when you use this app.

2. Use of Information
   We use the collected information to provide and improve our services, send you updates, and personalize your experience.

3. Data Security
   We implement security measures to protect your data, but we cannot guarantee the security of information transmitted through the app.

4. Cookies
   This app may use cookies to enhance your experience. You can disable cookies in your browser settings.

5. Third-Party Services
   The app may use third-party services, and their use of your information is governed by their respective privacy policies.

6. Children's Privacy
   This app is not intended for children under the age of 13. We do not knowingly collect personal information from children.

7. Changes to Privacy Policy
   We may update our privacy policy from time to time. You will be notified of any changes by posting the new privacy policy on this page.

8. Contact Information
   For questions about this privacy policy, please contact [contact email].
                ''',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
