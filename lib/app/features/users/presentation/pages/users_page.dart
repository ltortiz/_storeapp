import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/core/presentation/widgets/custom_app_bar.dart';
import 'package:storeapp/app/core/presentation/widgets/custom_dialog.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/features/users/presentation/bloc/users_bloc.dart';
import 'package:storeapp/app/features/users/presentation/bloc/users_event.dart';
import 'package:storeapp/app/features/users/presentation/bloc/users_state.dart';
import 'package:storeapp/app/features/users/presentation/model/user_model.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<UsersBloc>(),
      child: Scaffold(
        appBar: const CustomAppBar("Listado de Usuarios"),
        body: UserListWidget(),
      ),
    );
  }
}

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    bloc.add(GetUsersEvent());
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        switch (state) {
          case EmptyState() || LoadingState() || LoadDataState():
            break;
          case UsersErrorState():
            CustomDialog.show(
              context: context,
              title: "Error!!",
              message: state.message,
            );
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
          case EmptyState():
            return Center(child: Text("No hay usuarios"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.users.length,
              itemBuilder:
                  (context, index) => UserItemWidget(state.model.users[index]),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class UserItemWidget extends StatelessWidget {
  final UserModel user;

  const UserItemWidget(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 12.0,
          bottom: 12.0,
        ),
        child: Row(
          children: [
            Image.network(user.photoUrl, width: 120.0, fit: BoxFit.contain),
            Expanded(
              child: SizedBox(
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Nombre:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(user.name),
                    Text(
                      "Email:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(user.email.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
