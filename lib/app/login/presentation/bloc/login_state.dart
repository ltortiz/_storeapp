import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

sealed class LoginState {
  LoginState({required this.model});

  final LoginFormModel model;
}

final class InitialState extends LoginState {
  InitialState() : super(model: LoginFormModel(email: "a@a.com", password: "12345678"));
}

final class DataUpdateState extends LoginState {
  DataUpdateState({required super.model});
}

final class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.model});
}

final class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({required super.model, required this.message});
}
