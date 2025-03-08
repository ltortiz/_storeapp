import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/core/domain/use_case/profile_use_case.dart';
import 'package:storeapp/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:storeapp/app/features/profile/presentation/bloc/profile_state.dart';
import 'package:storeapp/app/features/profile/presentation/model/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LogoutUseCase logoutUseCase;
  final ProfileUseCase profileUseCase;

  ProfileBloc({required this.profileUseCase, required this.logoutUseCase})
    : super(LoadingState()) {
    on<GetUserEvent>(_getUserEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  Future<void> _getUserEvent(
    GetUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final ProfileModel result = await profileUseCase.invoke();
    final newState = LoadDataState(model: result);
    emit(newState);
  }

  Future<void> _logoutEvent(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await logoutUseCase.invoke();
    emit(LogoutState());
  }
}
