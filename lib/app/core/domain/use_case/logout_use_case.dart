import 'package:storeapp/app/core/domain/repository/session_repository.dart';

final class LogoutUseCase {
  late final SessionRepository sessionRepository;

  LogoutUseCase({required this.sessionRepository});

  Future<bool> invoke() {
    return sessionRepository.logout();
  }
}
