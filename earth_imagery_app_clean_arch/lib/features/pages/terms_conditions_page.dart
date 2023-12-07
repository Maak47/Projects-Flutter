import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '''
1. Acceptance of Terms
   By accessing or using this application, you agree to comply with and be bound by these terms and conditions.

2. Use of the App
   You agree to use the app for lawful purposes only and not to engage in any conduct that may harm the rights of others.

3. User Account
   To access certain features of the app, you may be required to create an account. You are responsible for maintaining the confidentiality of your account information.

4. Intellectual Property
   All content in this app, including text, graphics, logos, and images, is the property of the app owner and is protected by intellectual property laws.

5. Disclaimer of Warranties
   The app is provided "as is" without warranties of any kind, either expressed or implied.

6. Limitation of Liability
   The app owner shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of the app.

7. Modifications to Terms
   The app owner reserves the right to modify these terms and conditions at any time. Your continued use of the app after such modifications will constitute your acceptance of the updated terms.

8. Governing Law
   These terms and conditions are governed by and construed in accordance with the laws of [your jurisdiction].

9. Contact Information
   For any questions regarding these terms and conditions, please contact [contact email].
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
