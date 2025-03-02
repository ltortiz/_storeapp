import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/features/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<bool> login(LoginEntity loginEntity) async {
    late final bool isLogin;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEntity.email,
        password: loginEntity.password,
      );
      isLogin = true;
    } catch (e) {
      isLogin = false;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", isLogin);
    return isLogin;
  }
}
