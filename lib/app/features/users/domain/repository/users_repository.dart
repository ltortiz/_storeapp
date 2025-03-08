import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class UsersRepository {
  Future<List<UserEntity>> getUsers();
}
