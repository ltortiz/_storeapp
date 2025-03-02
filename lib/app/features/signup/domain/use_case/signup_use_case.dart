import 'package:storeapp/app/features/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/features/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/features/signup/presentation/model/signup_form_model.dart';

class SignupUseCase {
  late final SignupRepository signupRepository;

  SignupUseCase({required this.signupRepository});

  Future<bool> invoke(SignupFormModel signupFormModel) {
    final SignupEntity data = signupFormModel.toEntity();

    return signupRepository.signup(data);
  }
}
