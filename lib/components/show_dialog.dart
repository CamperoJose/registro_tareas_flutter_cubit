// error_dialog.dart
import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    Color? titleColor,
    Color? messageColor,
    TextStyle? titleTextStyle,
    TextStyle? messageTextStyle,
    String? additionalButtonText,
    VoidCallback? onAdditionalButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              icon != null
                  ? Icon(icon, color: titleColor ?? Colors.red)
                  : Container(),
              SizedBox(width: icon != null ? 8.0 : 0.0),
              Text(
                title,
                style: titleTextStyle ??
                    TextStyle(
                      color: titleColor ?? Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          content: Text(
            message,
            style: messageTextStyle ??
                TextStyle(
                  color: messageColor ?? Colors.black,
                ),
          ),
          actions: <Widget>[
            if (additionalButtonText != null &&
                onAdditionalButtonPressed != null)
              TextButton(
                child: Text(additionalButtonText),
                onPressed: onAdditionalButtonPressed,
              ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
