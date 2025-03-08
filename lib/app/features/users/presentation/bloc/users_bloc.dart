import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/features/users/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/features/users/presentation/bloc/users_event.dart';
import 'package:storeapp/app/features/users/presentation/bloc/users_state.dart';
import 'package:storeapp/app/features/users/presentation/model/user_model.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersBloc({required this.getUsersUseCase}) : super(LoadingState()) {
    on<GetUsersEvent>(_getUsersEvent);
  }

  Future<void> _getUsersEvent(
    GetUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    late UsersState newState;

    try {
      newState = LoadingState();
      emit(newState);

      final List<UserModel> result = await getUsersUseCase.invoke();

      if (result.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(model: state.model.copyWith(users: result));
      }
    } catch (e) {
      newState = UsersErrorState(
        model: state.model,
        message: "Error cargando usuarios",
      );
    }
    emit(newState);
  }
}
