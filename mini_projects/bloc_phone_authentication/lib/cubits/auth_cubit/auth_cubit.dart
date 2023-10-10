import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitial()) {
    void sendOTP(String phoneNumber) async {}
    void verifyOTP(String otp) async {}

    void signInWithPhone() async {}
  }
}
