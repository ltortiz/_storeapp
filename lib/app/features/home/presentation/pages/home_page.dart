import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';
import 'package:storeapp/app/core/presentation/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar("StoreApp"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            CardHomeWidget(
              title: "Usuarios",
              icon: Icons.person,
              color: AppTheme.secondaryColor,
              routeName: "users",
            ),
            CardHomeWidget(
              title: "Productos",
              icon: Icons.shopping_bag,
              color: AppTheme.accentColor,
              routeName: "products",
            ),
          ],
        ),
      ),
    );
  }
}

class CardHomeWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String routeName;

  const CardHomeWidget({
    required this.title,
    required this.icon,
    required this.color,
    required this.routeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(routeName),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: color,
                child: Icon(icon, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
    );
  }
}
