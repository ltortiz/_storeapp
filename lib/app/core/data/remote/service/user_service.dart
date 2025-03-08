import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

final class UserService {
  final Dio dio;

  final String _baseUrl = "https://storeapp-56f38-default-rtdb.firebaseio.com/";

  UserService({required this.dio});

  Future<bool> add(UserDataModel user) async {
    try {
      await dio.put("$_baseUrl/users/${user.id}.json", data: user.toJson());
    } catch (e) {
      throw Exception("Error: $e");
    }
    return true;
  }

  Future<UserDataModel> find(String id) async {
    late final UserDataModel user;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/users/$id.json",
      );
      if (response.data != null) {
        user = UserDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return user;
  }

  Future<List<UserDataModel>> getAll() async {
    final List<UserDataModel> users = [];
    try {
      final Response<Map> response = await dio.get("$_baseUrl/users.json");
      if (response.data != null) {
        response.data?.forEach((key, value) {
          users.add(UserDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return users;
  }

  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseUrl/users/$id.json");
    } catch (e) {
      throw Exception("Error: $e");
    }
    return true;
  }
}
