import 'package:earth_imagery_app/helpers/appwrite_service.dart';
import 'package:flutter/material.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  List<Map<String, String>> plans = [
    {
      'title': 'Elite Plan',
      'subtitle': 'Get access to All the Functionalities',
      'priceUSD': '25'
    },
    {
      'title': 'Rookie Plan',
      'subtitle': 'Get access to Aerosol and Cloud images',
      'priceUSD': '15'
    },
    {
      'title': 'Novice Plan',
      'subtitle': 'Get Access to Aerosol images',
      'priceUSD': '12'
    },
  ];

  final ValueNotifier<String> selectedCurrency = ValueNotifier<String>('USD');
  final Map<String, double> currencyRates = {
    'USD': 1.0,
    'EUR': 0.93,
    'BSD': 0.8,
    'IDR': 15540.0,
    // Add more currencies and their conversion rates as needed
  };

  final List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.grey,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subscription Plan'),
              const Text(
                  'Choose a subscription Plan for additional functionality of the app'),
              _buildCurrencySelection(),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final plan = plans[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Text(plan['title'] ?? ''),
                          subtitle: Text(
                            plan['subtitle'] ?? '',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          trailing: _buildPriceWidget(plan),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: const Text('Confirm Payment'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No'))
                                      ],
                                    ));
                            _updateSubscription(plan);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Go back')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencySelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: currencyRates.keys.map((currency) {
        return _buildRadioButton(currency);
      }).toList(),
    );
  }

  Widget _buildRadioButton(String currency) {
    return Row(
      children: [
        Radio<String>(
          value: currency,
          groupValue: selectedCurrency.value,
          onChanged: (value) {
            selectedCurrency.value = value!;
            setState(() {});
          },
        ),
        Text(currency),
      ],
    );
  }

  Widget _buildPriceWidget(Map<String, String> plan) {
    final priceUSD = double.parse(plan['priceUSD']!);
    final convertedPrice = priceUSD * currencyRates[selectedCurrency.value]!;
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '${convertedPrice.toStringAsFixed(2)} ',
            style: const TextStyle(color: Colors.green, fontSize: 25)),
        TextSpan(
            text: selectedCurrency.value,
            style: const TextStyle(color: Colors.blue, fontSize: 20)),
      ]),
    );
  }

  void _updateSubscription(Map<String, String> plan) {
    bool isAerosolActive = true; // default value for aerosol
    bool isCloudsActive = true; // default value for clouds

    if (plan['title'] == 'Novice Plan') {
      isCloudsActive = false; // set aerosol to false for Novice Plan
    }
    // Call the update functions based on the plan
    _updateFunction(isAerosolActive, isCloudsActive);
  }

  void _updateFunction(bool isAerosolActive, bool isCloudsActive) {
    // Call your Appwrite service update function here

    // For example:
    updateUserPreferences(isAerosolActive, isCloudsActive);
    ('Updating preferences - Aerosol: $isAerosolActive, Clouds: $isCloudsActive');
  }
}
