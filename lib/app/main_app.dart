import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';
import 'package:storeapp/app/features/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/features/profile/presentation/pages/profile_page.dart';
import 'package:storeapp/app/features/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/features/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/features/signup/presentation/pages/signup_page.dart';
import 'package:storeapp/app/features/products/presentation/pages/products_page.dart';
import 'package:storeapp/app/features/users/presentation/pages/users_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: "/home",
      routes: [
        GoRoute(
          path: "/login",
          builder: (_, _) => LoginPage(),
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (authenticated || user != null) {
              return "/home";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SignUpPage(),
          name: "sign-up",
        ),
        GoRoute(
          path: "/home",
          builder: (_, _) => HomePage(),
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (!authenticated || user == null) {
              return "/login";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/profile",
          builder: (_, _) => ProfilePage(),
          name: "profile",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (!authenticated || user == null) {
              return "/login";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/products",
          builder: (_, _) => ProductsPage(),
          name: "products",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (!authenticated || user == null) {
              return "/login";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/form-product",
          builder: (_, _) => FormProductPage(),
          name: "form-product",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (!authenticated || user == null) {
              return "/login";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/form-product/:id",
          builder:
              (_, state) => FormProductPage(id: state.pathParameters["id"]),
          name: "form-product-u",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (!authenticated || user == null) {
              return "/login";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/users",
          builder: (_, _) => UsersPage(),
          name: "users",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            User? user = FirebaseAuth.instance.currentUser;
            if (!authenticated || user == null) {
              return "/login";
            }
            return null;
          },
        ),
      ],
    );
    return SafeArea(
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
