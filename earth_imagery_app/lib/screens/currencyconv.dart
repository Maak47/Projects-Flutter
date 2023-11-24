import 'package:flutter/material.dart';

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
