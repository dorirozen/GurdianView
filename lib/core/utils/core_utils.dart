import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors.dart';

class CoreUtils {
  CoreUtils._();
  static void showSnackBar(BuildContext context, String message,
      [Color? color]) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          '$message',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? MyColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
      ));
  }

  static void showLoadingDialog(
      BuildContext context, String title, String bio) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
        title: Text(title),
        contentPadding: const EdgeInsets.all(20.0),
        content: Text(bio),
      ),
    );
  }
}
