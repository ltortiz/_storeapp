import 'package:storeapp/app/features/users/domain/repository/users_repository.dart';
import 'package:storeapp/app/features/users/presentation/model/user_model.dart';

class GetUsersUseCase {
  late final UsersRepository usersRepository;

  GetUsersUseCase({required this.usersRepository});

  Future<List<UserModel>> invoke() async {
    try {
      return (await usersRepository.getUsers())
          .map((item) => item.toUserModel())
          .toList();
    } catch (e) {
      throw (Exception(e));
    }
  }
}
