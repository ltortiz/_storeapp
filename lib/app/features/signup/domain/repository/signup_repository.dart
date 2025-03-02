import 'package:storeapp/app/features/signup/domain/entity/signup_entity.dart';

abstract class SignupRepository {
  Future<bool> signup(SignupEntity loginEntity);
}
