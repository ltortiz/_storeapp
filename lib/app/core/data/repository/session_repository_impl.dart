import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    return await prefs.remove("login");
  }
}
