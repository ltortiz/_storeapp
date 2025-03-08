import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final UserService userService;

  SessionRepositoryImpl({required this.userService});

  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    return await prefs.remove("login");
  }

  @override
  Future<UserDataModel> findUser(String id) {
    return userService.find(id);
  }
}
