import 'package:storeapp/app/features/signup/domain/entity/signup_entity.dart';

final class SignupFormModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String photo;

  SignupFormModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.photo,
  });

  SignupFormModel copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? photo,
  }) {
    return SignupFormModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      photo: photo ?? this.photo,
    );
  }

  SignupEntity toEntity() => SignupEntity(
    id: id,
    name: name,
    email: email,
    password: password,
    photo: photo,
  );
}
