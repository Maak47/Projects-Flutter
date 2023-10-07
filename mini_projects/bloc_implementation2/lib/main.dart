import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import './blocs/internet_bloc/internet_bloc.dart';
import 'cubits/internet_cubit.dart' as cubit;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // This is for Bloc
      // create: (context) => InternetBloc(),
      // This is for Cubit
      create: (context) => cubit.InternetCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Bloc-Implementation'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          //For bloc
          // child: BlocConsumer<InternetBloc, InternetState>(
          // For cubit
          child: BlocConsumer<cubit.InternetCubit, cubit.InternetState>(
              listener: (context, state) {
            //For bloc
            // if (state is InternetGainedState) {
            //For cubit
            if (state == cubit.InternetState.Gained) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Connected!'),
                backgroundColor: Colors.green,
              ));
            } else if (state == cubit.InternetState.Lost) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Not Connected!'),
                backgroundColor: Colors.red,
              ));
            }
          }, builder: (context, state) {
            if (state == cubit.InternetState.Gained) {
              return const Text('Connected!');
            } else if (state == cubit.InternetState.Lost) {
              return const Text('Not Connected!');
            } else {
              return const Text('Loading...');
            }
          }),
        ),
      ),
    );
  }
}
