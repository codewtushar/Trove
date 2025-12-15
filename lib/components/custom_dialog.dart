import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmText,
  String cancelText = "Cancel",
  Color confirmColor = Colors.red,
  required VoidCallback onConfirm,
  bool isDestructive = false,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.black87,
        title: Text(
          title,
          style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold,
            color: Colors.white54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              cancelText,
              style: GoogleFonts.martianMono(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              confirmText,
              style: GoogleFonts.martianMono(
                color: confirmColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}

