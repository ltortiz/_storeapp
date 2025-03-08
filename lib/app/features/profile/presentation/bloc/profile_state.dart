import 'package:storeapp/app/features/profile/presentation/model/profile_model.dart';

sealed class ProfileState {
  ProfileState({required this.model});

  final ProfileModel model;
}

final class LoadingState extends ProfileState {
  final String message;
  LoadingState({this.message = "Cargando Datos..."})
    : super(model: ProfileModel(id: "", name: "", email: "", photo: ""));
}

final class LoadDataState extends ProfileState {
  LoadDataState({required super.model});
}

final class LogoutState extends ProfileState {
  LogoutState()
    : super(model: ProfileModel(id: "", name: "", email: "", photo: ""));
}
