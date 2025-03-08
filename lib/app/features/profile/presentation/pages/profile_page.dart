import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:storeapp/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:storeapp/app/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<ProfileBloc>(),
      child: Scaffold(body: ProfileWidget()),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    bloc.add(GetUserEvent());
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        switch (state) {
          case LoadingState() || LoadDataState():
            break;
          case LogoutState():
            print("Logout");
            context.go("/login");
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text(state.message),
                ],
              ),
            );
          case LoadDataState():
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.3),
                      backgroundImage: NetworkImage(state.model.photo),
                      child: null,
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          state.model.name,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.email, color: AppTheme.iconColor),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      state.model.email,
                                      style: TextStyle(
                                        color: AppTheme.textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(height: 16),
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user,
                                    color: AppTheme.iconColor,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      state.model.id,
                                      style: TextStyle(
                                        color: AppTheme.textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.secondaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                                () => showDialog<void>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Cerrar Sesión"),
                                      titleTextStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      content: Text(
                                        "Está seguro de cerrar sesión?",
                                      ),
                                      actions: [
                                        FilledButton(
                                          onPressed: () {
                                            bloc.add(LogoutEvent());
                                            Navigator.pop(context, "Ok");
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                          ),
                                          child: Text("Ok"),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context, "Cancelar");
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                          ),
                                          child: Text("Cancelar"),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Cerrar sesión",
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
            );
          default:
            return Container();
        }
      },
    );
  }
}
