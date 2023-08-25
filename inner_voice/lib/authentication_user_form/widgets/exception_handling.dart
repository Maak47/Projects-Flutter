import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({super.key, required this.errorMessage});
  final String? errorMessage;

  Widget viewSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return SnackBar(
      content: Center(
        child: Text(errorMessage ?? 'Something went Wrong...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewSnackBar(context),
    );
  }
}
