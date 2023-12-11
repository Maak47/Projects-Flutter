import 'package:bloc_practice_counter/counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          return Text(
            '$state',
            style: textTheme.displayMedium,
          );
        }),
      ),
      floatingActionButton: Column(children: [
        FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().decrement(),
          child: const Icon(Icons.remove),
        )
      ]),
    );
  }
}
