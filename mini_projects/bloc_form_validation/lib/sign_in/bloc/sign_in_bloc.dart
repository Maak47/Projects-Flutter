import 'package:bloc_form_validation/sign_in/bloc/sign_in_event.dart';
import 'package:bloc_form_validation/sign_in/bloc/sign_in_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState('Please Enter a Valid Email address.'));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState('Password Should be 8 characters Long.'));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
