import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
  late final LoginUseCase _loginUseCase;

  LoginBloc(): super(InitialState()) {
    on<EmailChangeEvent>(_emailChangedEvent);
    on<PasswordChangeEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);
    _loginUseCase = LoginUseCase();
  }
  

  void _emailChangedEvent(EmailChangeEvent event, Emitter<LoginState> emit) {
    final newState = DataUpdateState(model: state.model.copyWith(email: event.email));
    emit(newState);
  }

  void _passwordChangedEvent(PasswordChangeEvent event, Emitter<LoginState> emit) {
    final newState = DataUpdateState(model: state.model.copyWith(password: event.password));
    emit(newState);
  }

  void _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
    final bool result = _loginUseCase.invoke(state.model);
    print(result ? "Inicio!!!!": "No inicio :(");
    late final newState;
    if (result) {
      newState = LoginSuccessState(model: state.model);
    } else {
      newState = LoginErrorState(model: state.model, message: "Error al iniciar sesión");
    }
    emit(newState);
  }
}
