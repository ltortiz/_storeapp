import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

final class UserService {
  final Dio dio;

  final String _baseUrl = "https://storeapp-56f38-default-rtdb.firebaseio.com/";

  UserService({required this.dio});

  Future<bool> add(UserDataModel user) async {
    try {
      await dio.post("$_baseUrl/users.json", data: user.toJson());
    } catch (e) {
      throw Exception("Error: $e");
    }
    return true;
  }
}
