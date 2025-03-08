import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/features/users/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UserService userService;

  UsersRepositoryImpl({required this.userService});

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      return (await userService.getAll())
          .map((item) => item.toUserEntity())
          .toList();
    } catch (e) {
      throw (Exception(e));
    }
  }
}
