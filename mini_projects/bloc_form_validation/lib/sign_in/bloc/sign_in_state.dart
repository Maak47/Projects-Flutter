sealed class SignInState {}

class SignInInitialState extends SignInState {}

class SignInValidState extends SignInState {}

class SignInInvalidState extends SignInState {}

class SignInErrorState extends SignInState {
  SignInErrorState(this.errorMessage);
  final String errorMessage;
}

class SignInLoadingState extends SignInState {}
