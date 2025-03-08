import 'package:storeapp/app/features/users/presentation/model/user_model.dart';

class UsersModel {
  final List<UserModel> users;

  UsersModel({required this.users});

  UsersModel copyWith({List<UserModel>? users}) {
    return UsersModel(users: users ?? this.users);
  }
}
