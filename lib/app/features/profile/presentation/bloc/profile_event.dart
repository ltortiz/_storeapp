sealed class ProfileEvent {}

final class GetUserEvent extends ProfileEvent {
  GetUserEvent();
}

class LogoutEvent extends ProfileEvent {
  LogoutEvent();
}
