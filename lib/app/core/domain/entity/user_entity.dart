import 'package:storeapp/app/features/users/presentation/model/user_model.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String urlPhoto;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.urlPhoto,
  });

  UserModel toUserModel() =>
      UserModel(id: id, name: name, email: email, photoUrl: urlPhoto);
}
