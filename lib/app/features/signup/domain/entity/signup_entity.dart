import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

class SignupEntity {
  final String id;
  final String name;
  final String email;
  final String password;
  final String photo;

  SignupEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.photo,
  });

  UserDataModel toUserDataModel(String uid) =>
      UserDataModel(id: uid, name: name, email: email, photo: photo);
}
