import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';
import 'package:storeapp/app/core/presentation/widgets/custom_dialog.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/features/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/features/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/features/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/features/login/presentation/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // body: SafeArea(child: Text('Hello World!')),
        body: Column(
          children: [
            HeaderLoginWidget(),
            BodyLoginWidget(),
            FooterLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Column(
        children: [
          Divider(color: AppTheme.textColor.withOpacity(0.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aún no tienes cuenta?",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textColor),
              ),
              SizedBox(width: 32.0),
              GestureDetector(
                onTap: () => context.pushNamed("sign-up"),
                child: Text(
                  "Registrate acá",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    _autoShowTimer?.cancel();

    if (!_showPassword) {
      _autoShowTimer = Timer(Duration(seconds: 5), () {
        setState(() {
          _showPassword = false;
        });
      });
    }

    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case LoginSuccessState():
            context.pushReplacementNamed("home");
            break;
          case LoginErrorState():
            CustomDialog.show(
              context: context,
              title: "Error!!",
              message: state.message,
            );
            break;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm =
              validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null;
          return Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: state.model.email,
                        onChanged:
                            (value) => bloc.add(EmailChangeEvent(email: value)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateEmail,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.email, color: AppTheme.iconColor),
                          hintText: "Escriba su email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: state.model.password,
                        onChanged:
                            (value) =>
                                bloc.add(PasswordChangeEvent(password: value)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validatePassword,
                        style: TextStyle(color: AppTheme.textColor),
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          icon: Icon(Icons.lock, color: AppTheme.iconColor),
                          hintText: "Escriba su contraseña",
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppTheme.iconColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: AppTheme.inputBackgroundColor,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_showPassword,
                      ),
                      SizedBox(height: 16.0),
                      FilledButton(
                        onPressed:
                            isValidForm ? () => bloc.add(SubmitEvent()) : null,
                        style: FilledButton.styleFrom(
                          disabledBackgroundColor: AppTheme.primaryColor
                              .withOpacity(0.3),
                          disabledForegroundColor: Colors.white70,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Iniciar Sesión",
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Inicio de Sesión",
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
