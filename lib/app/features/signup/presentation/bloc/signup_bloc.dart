import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/features/signup/domain/use_case/signup_use_case.dart';
import 'package:storeapp/app/features/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/features/signup/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase signupUseCase;

  SignupBloc({required this.signupUseCase}) : super(InitialState()) {
    on<NameChangedEvent>(_nameChangedEvent);
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<ConfirmPasswordChangedEvent>(_confirmPasswordChangedEvent);
    on<PhotoChangedEvent>(_photoChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  void _nameChangedEvent(NameChangedEvent event, Emitter<SignupState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(name: event.name),
    );
    emit(newState);
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<SignupState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(email: event.email),
    );
    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );
    emit(newState);
  }

  void _confirmPasswordChangedEvent(
    ConfirmPasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(confirmPassword: event.confirmPassword),
    );
    emit(newState);
  }

  void _photoChangedEvent(PhotoChangedEvent event, Emitter<SignupState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(photo: event.photo),
    );
    emit(newState);
  }

  Future<void> _submitEvent(
    SubmitEvent event,
    Emitter<SignupState> emit,
  ) async {
    late final SignupState newState;
    try {
      final bool result = await signupUseCase.invoke(state.model);
      if (result) {
        newState = SubmitSuccessState(model: state.model);
      } else {
        throw (Exception());
      }
    } catch (e) {
      newState = SubmitErrorState(
        model: state.model,
        message: "Error al registrar el usuario",
      );
    }
    emit(newState);
  }
}
