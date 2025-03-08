import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

abstract class SessionRepository {
  Future<bool> logout();
  Future<UserDataModel> findUser(String id);
}
