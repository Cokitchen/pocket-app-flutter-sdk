import 'package:flutter/material.dart';
import 'package:pocket_app_flutter_sdk/views/web.dart';

class Pocket {
  Pocket._();

  static Future<void> buildWithOptions(
    BuildContext context, {
    Map<String, dynamic>? pocketOptions,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Web(),
      ),
    );
  }
}
