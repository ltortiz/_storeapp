sealed class SignupEvent {}

class NameChangedEvent extends SignupEvent {
  final String name;
  NameChangedEvent({required this.name});
}

class EmailChangedEvent extends SignupEvent {
  final String email;
  EmailChangedEvent({required this.email});
}

class PasswordChangedEvent extends SignupEvent {
  final String password;
  PasswordChangedEvent({required this.password});
}

class ConfirmPasswordChangedEvent extends SignupEvent {
  final String confirmPassword;
  ConfirmPasswordChangedEvent({required this.confirmPassword});
}

class PhotoChangedEvent extends SignupEvent {
  final String photo;
  PhotoChangedEvent({required this.photo});
}

class SubmitEvent extends SignupEvent {
  SubmitEvent();
}
