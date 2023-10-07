sealed class SignInEvent {}

class SignInTextChangedEvent extends SignInEvent {
  SignInTextChangedEvent(this.emailValue, this.passwordValue);
  final String emailValue;
  final String passwordValue;
}

class SignInSubmittedEvent extends SignInEvent {
  SignInSubmittedEvent(this.email, this.password);
  final String email;
  final String password;
}
