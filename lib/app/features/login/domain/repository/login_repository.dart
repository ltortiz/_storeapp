import 'package:storeapp/app/features/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  Future<bool> login(LoginEntity loginEntity);
}
