import 'package:storeapp/app/features/users/presentation/model/users_model.dart';

sealed class UsersState {
  UsersState({required this.model});

  final UsersModel model;
}

final class EmptyState extends UsersState {
  EmptyState() : super(model: UsersModel(users: []));
}

final class LoadingState extends UsersState {
  final String message;
  LoadingState({this.message = "Cargando Usuarios..."})
    : super(model: UsersModel(users: []));
}

final class LoadDataState extends UsersState {
  LoadDataState({required super.model});
}

final class UsersErrorState extends UsersState {
  final String message;
  UsersErrorState({required super.model, required this.message});
}
