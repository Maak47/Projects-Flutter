// main.dart

import 'package:bloc_practice/bloc/counter_bloc.dart';
import 'package:bloc_practice/bloc/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: MyHomePage(), // Use MyHomePage as the child widget
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Counter'),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text('$state', style: Theme.of(context).textTheme.headline4);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('counterView_increment_floatingActionButton'),
        child: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<CounterBloc>(context).add(CounterIncrementPressed());
        },
      ),
    );
  }
}
