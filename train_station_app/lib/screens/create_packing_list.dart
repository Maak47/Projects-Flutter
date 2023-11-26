import 'package:flutter/material.dart';

class CreatePackingList extends StatefulWidget {
  const CreatePackingList({super.key});

  @override
  State<CreatePackingList> createState() => _CreatePackingListState();
}

class _CreatePackingListState extends State<CreatePackingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CREATE LIST'),
      ),
    );
  }
}
