import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';
import 'package:storeapp/app/core/presentation/widgets/custom_dialog.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/features/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/features/signup/presentation/bloc/signup_state.dart';
import 'package:storeapp/app/features/signup/presentation/pages/signup_mixin.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<SignupBloc>(),
      child: Scaffold(
        body: Column(children: [HeaderSignUpWidget(), BodySignUpWidget()]),
      ),
    );
  }
}

class BodySignUpWidget extends StatefulWidget {
  const BodySignUpWidget({super.key});

  @override
  State<BodySignUpWidget> createState() => _BodySignUpWidgetState();
}

class _BodySignUpWidgetState extends State<BodySignUpWidget> with SignupMixin {
  @override
  Widget build(BuildContext context) {
    final SignupBloc bloc = context.read<SignupBloc>();
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            context.pushReplacementNamed("login");
            break;
          case SubmitErrorState():
            CustomDialog.show(
              context: context,
              title: "Error!!",
              message: state.message,
            );
            break;
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          final bool isValidForm =
              validateName(state.model.name) == null &&
              validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null &&
              validateConfirmPassword(state.model.confirmPassword) == null &&
              validatePhoto(state.model.photo) == null;
          return Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  right: 32.0,
                  left: 32.0,
                  top: 32.0,
                  bottom: 32.0,
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: state.model.name,
                        onChanged:
                            (value) => bloc.add(NameChangedEvent(name: value)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateName,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Nombre",
                          icon: Icon(Icons.person, color: AppTheme.iconColor),
                          hintText: "Escriba su nombre",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        initialValue: state.model.email,
                        onChanged:
                            (value) =>
                                bloc.add(EmailChangedEvent(email: value)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateEmail,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Correo electrónico",
                          icon: Icon(Icons.email, color: AppTheme.iconColor),
                          hintText: "Escriba su correo",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        initialValue: state.model.password,
                        onChanged:
                            (value) =>
                                bloc.add(PasswordChangedEvent(password: value)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validatePassword,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          icon: Icon(Icons.lock, color: AppTheme.iconColor),
                          hintText: "Escriba su contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        initialValue: state.model.confirmPassword,
                        onChanged:
                            (value) => bloc.add(
                              ConfirmPasswordChangedEvent(
                                confirmPassword: value,
                              ),
                            ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateConfirmPassword,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Confirmar Contraseña",
                          icon: Icon(Icons.password, color: AppTheme.iconColor),
                          hintText: "Repita su contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        initialValue: state.model.photo,
                        onChanged:
                            (value) =>
                                bloc.add(PhotoChangedEvent(photo: value)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validatePhoto,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Foto",
                          icon: Icon(Icons.photo, color: AppTheme.iconColor),
                          hintText: "Escriba la url de su foto",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.url,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child:
                            state.model.photo.isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    state.model.photo,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                )
                                : Icon(
                                  Icons.image,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.secondaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Volver",
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              onPressed:
                                  isValidForm
                                      ? () {
                                        bloc.add(SubmitEvent());
                                      }
                                      : null,
                              style: FilledButton.styleFrom(
                                disabledBackgroundColor: AppTheme.primaryColor
                                    .withOpacity(0.5),
                                disabledForegroundColor: Colors.white70,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Registrar",
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderSignUpWidget extends StatelessWidget {
  const HeaderSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.fitHeight,
            // "https://www.infobae.com/resizer/v2/https%3A%2F%2Fs3.amazonaws.com%2Farc-wordpress-client-uploads%2Finfobae-wp%2Fwp-content%2Fuploads%2F2017%2F04%2F06155038%2Fperro-beso.jpg?auth=7db092219938909c16f466d602dcf2715cb44547bae1b45714fbfc66be4b16e9&smart=true&width=1200&height=900&quality=85",
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Registrar",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
