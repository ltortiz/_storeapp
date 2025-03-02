import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/features/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/features/signup/domain/repository/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final UserService userService;

  SignupRepositoryImpl({required this.userService});

  @override
  Future<bool> signup(SignupEntity signupEntity) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: signupEntity.email,
            password: signupEntity.password,
          );
      if (userCredential.user != null) {
        await FirebaseAuth.instance.signOut();
        await userService.add(
          signupEntity.toUserDataModel(userCredential.user!.uid),
        );
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return true;
  }
}
