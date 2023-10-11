import 'package:bloc_phone_authentication/screen/verify_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/auth_cubit/auth_state.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Phone number',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthCodeSentState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerificationScreen()));
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              String phoneNumber = '+91${phoneController.text}';
                              BlocProvider.of<AuthCubit>(context)
                                  .sendOTP(phoneNumber);
                            },
                            child: const Text('Sign In'),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),

          // SafeArea(
          //   child: ListView(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(
          //           vertical: 20,
          //           horizontal: 30,
          //         ),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             TextField(
          //               decoration: const InputDecoration(
          //                 hintText: 'Enter Phone number',
          //                 border: OutlineInputBorder(),
          //                 counterText: '',
          //               ),
          //               maxLength: 10,
          //               keyboardType: TextInputType.number,
          //               controller: phoneController,
          //             ),
          //             const SizedBox(
          //               height: 20,
          //             ),
          //             BlocConsumer<AuthCubit, AuthState>(
          //               listener: (context, state) {
          //                 if (state is AuthCodeSentState) {
          //                   Navigator.of(context).push(MaterialPageRoute(
          //                       builder: (context) => VerificationScreen()));
          //                 }
          //               },
          //               builder: (context, state) {
          //                 if (state is AuthLoadingState) {
          //                   return const Center(child: LinearProgressIndicator());
          //                 }
          //                 return SizedBox(
          //                   width: MediaQuery.of(context).size.width,
          //                   child: ElevatedButton(
          //                     onPressed: () {
          //                       String phoneNumber = '+91${phoneController.text}';
          //                       BlocProvider.of<AuthCubit>(context)
          //                           .sendOTP(phoneNumber);
          //                     },
          //                     child: const Text('Sign In'),
          //                   ),
          //                 );
          //               },
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ));
  }
}
