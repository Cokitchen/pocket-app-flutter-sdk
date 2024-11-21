import 'package:flutter/material.dart';
import 'package:pocket_app_flutter_sdk/model/pocket_option.dart';
import 'package:pocket_app_flutter_sdk/views/web.dart';

class Pocket {
  Pocket._();

  static Future<void> buildWithOptions(
    BuildContext context,
    PocketOption pocketOptions,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Web(
          pocketOptions: pocketOptions,
        ),
      ),
    );
  }
}
