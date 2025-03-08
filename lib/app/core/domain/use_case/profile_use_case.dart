import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';
import 'package:storeapp/app/features/profile/presentation/model/profile_model.dart';

class ProfileUseCase {
  late final SessionRepository sessionRepository;

  ProfileUseCase({required this.sessionRepository});

  Future<ProfileModel> invoke() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    UserDataModel userData = await sessionRepository.findUser(currentUser!.uid);
    return UserDataModel(
      id: currentUser.uid,
      name: userData.name,
      email: currentUser.email!,
      photo: userData.photo,
    ).toProductFormModel();
  }
}
