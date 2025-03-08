import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/features/profile/presentation/model/profile_model.dart';

class UserDataModel {
  final String id;
  late final String name;
  late final String email;
  late final String photo;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "uid": id,
      "name": name,
      "email": email,
      "photo": photo,
    };
  }

  ProfileModel toProductFormModel() =>
      ProfileModel(id: id, name: name, email: email, photo: photo);

  UserDataModel.fromJson(String this.id, Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    photo = json["photo"];
  }

  UserEntity toUserEntity() =>
      UserEntity(id: id, name: name, email: email, urlPhoto: photo);
}
