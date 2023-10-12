import 'package:bloc_generated_routes/cubits/first_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'First Screen',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/second');
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(child: BlocBuilder<FirstCubit, int>(
          builder: (context, state) {
            return Text(
              state.toString(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<FirstCubit>(context).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
