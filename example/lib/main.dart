import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocket_app_flutter_sdk/pocket_app_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Pocket.buildWithOptions(
                  context,
                  PocketOption(
                    key: "TPM_TEST_7bQG1GAUbc7PSzZ8oPYY45Gm17tlhYmxUVi",
                    mode: "test",
                    narration: "Testing pay with pocket",
                    meta: {
                      "transactionId": "1234567890",
                      "timestamp": DateTime.now().toIso8601String(),
                      "currency": "NGN",
                      "senderAccount": "1234567890",
                      "recipientAccount": "987654321",
                      "transactionType": "Transfer",
                      "description": "Payment for services",
                      "status": "Completed",
                    },
                    amount: 4400000,
                    onClose: (message) {
                      log('onClose: $message');
                    },
                    onError: (message) {
                      log('onError: $message');
                    },
                    onSuccess: (message) {
                      log('onSuccess: $message');
                    },
                    onOpen: (message) {
                      log('onOpen: $message');
                    },
                    onPending: (message) {
                      log('onPending: $message');
                    },
                  ),
                );
              },
              child: const Text('Pay with Pocket'),
            ),
          ],
        ),
      ),
    );
  }
}
