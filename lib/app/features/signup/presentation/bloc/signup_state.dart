import 'package:storeapp/app/features/signup/presentation/model/signup_form_model.dart';

sealed class SignupState {
  SignupState({required this.model});

  final SignupFormModel model;
}

final class InitialState extends SignupState {
  InitialState()
    : super(
        model: SignupFormModel(
          id: "",
          name: "",
          email: "",
          password: "",
          confirmPassword: "",
          photo: "",
        ),
      );
}

final class DataUpdateState extends SignupState {
  DataUpdateState({required super.model});
}

final class SubmitSuccessState extends SignupState {
  SubmitSuccessState({required super.model});
}

final class SubmitErrorState extends SignupState {
  final String message;
  SubmitErrorState({required super.model, required this.message});
}
