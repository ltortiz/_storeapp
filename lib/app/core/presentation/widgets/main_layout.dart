import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Aplicación"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _signOut(context);
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'user',
                    enabled: false,
                    child: Text(
                      user?.email ?? "Usuario desconocido",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: AppTheme.iconColor),
                        const SizedBox(width: 8),
                        const Text("Cerrar sesión"),
                      ],
                    ),
                  ),
                ],
            icon: Icon(Icons.account_circle, color: AppTheme.iconColor),
          ),
        ],
      ),
      body: child, // Aquí se mostrará el contenido dinámico
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      GoRouter.of(context).go("/login");
    }
  }
}
