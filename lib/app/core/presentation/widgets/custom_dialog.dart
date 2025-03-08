import 'package:flutter/material.dart';

class CustomDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    Color titleColor = Colors.red,
    Color buttonColor = Colors.grey,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(message),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(backgroundColor: buttonColor),
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }
}
