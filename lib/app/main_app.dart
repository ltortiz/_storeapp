import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: "/", builder: (_, _) => LoginPage(), name: "login"),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SignUpPage(),
          name: "sign-up",
        ),
        GoRoute(
          path: "/home",
          builder: (_, _) => HomePage(),
          name: "home",
        ),
        
      ],
    );
    return SafeArea(child: MaterialApp.router(routerConfig: router));
  }
}
