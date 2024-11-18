library pocket_app_flutter_sdk;

import 'package:flutter/material.dart';

class PocketApp extends StatefulWidget {
  const PocketApp({super.key});

  @override
  State<PocketApp> createState() => _PocketAppState();
}

class _PocketAppState extends State<PocketApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Pocket App Flutter SDK"),
    );
  }
}
