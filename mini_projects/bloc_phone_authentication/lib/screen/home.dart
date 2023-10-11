import 'package:bloc_phone_authentication/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/auth_cubit/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: Center(child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is AuthLoggedOutState){
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignInScreen()));
            }
          },
          builder: (context, state) {

            return IconButton(icon: const Icon(Icons.logout), onPressed: () {
  BlocProvider.of<AuthCubit>(context).logOut();
            },);
          },
        ),),
      ),
    );
  }
}
