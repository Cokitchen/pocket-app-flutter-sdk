import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pocket_app_flutter_sdk/model/pocket_option.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:pocket_app_flutter_sdk/raw/pocket_html.dart';

class Web extends StatefulWidget {
  const Web({
    Key? key,
    required this.pocketOptions,
  }) : super(key: key);

  final PocketOption pocketOptions;
  // final Function(String data)? onSuccess;
  // final Function(String message)? onError;
  // final Function(String message)? onClose;
  // final Function(String message)? onPending;
  // final Function(String message)? onOpen;

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("FlutterOnSuccess",
          onMessageReceived: onFlutterSuccess)
      ..addJavaScriptChannel("FlutterOnError",
          onMessageReceived: onFlutterError)
      ..addJavaScriptChannel("FlutterOnClose",
          onMessageReceived: onFlutterClose)
      ..addJavaScriptChannel("FlutterOnPending",
          onMessageReceived: onFlutterPending)
      ..addJavaScriptChannel(
        "FlutterOnOpen",
        onMessageReceived: onFlutterOpen,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: onPageLoaded,
          onNavigationRequest: (NavigationRequest request) {
            if (Platform.isAndroid) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent("Flutter;Webview")
      ..loadHtmlString(
          buildPocketWithOptions(pocketOptions: widget.pocketOptions));
  }

  void onFlutterSuccess(JavaScriptMessage message) {
    log('Pocket SDK Success: ${message.message}');
    if (widget.pocketOptions.onSuccess != null) {
      widget.pocketOptions.onSuccess!(message.message);
    }
  }

  void onFlutterError(JavaScriptMessage message) {
    if (widget.pocketOptions.onError != null) {
      widget.pocketOptions
          .onError!(jsonDecode(message.message)["data"]["error"].toString());
    }
  }

  void onFlutterClose(JavaScriptMessage message) {
    if (widget.pocketOptions.onClose != null) {
      widget.pocketOptions.onClose!(message.message);
    } else {
      Navigator.pop(context);
    }
  }

  void onFlutterPending(JavaScriptMessage message) {
    if (widget.pocketOptions.onPending != null) {
      widget.pocketOptions.onPending!(message.message);
    }
  }

  void onFlutterOpen(JavaScriptMessage message) {
    if (widget.pocketOptions.onOpen != null) {
      widget.pocketOptions.onOpen!(message.message);
    }
  }

  void onPageLoaded(String _) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(30),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // InkWell(
      //       //   onTap: () {
      //       //     if (widget.pocketOptions.onClose != null) {
      //       //       widget.pocketOptions.onClose!("{event:'eventClose'}");
      //       //     }
      //       //     Navigator.pop(context);
      //       //   },
      //       //   child: const Padding(
      //       //     padding: EdgeInsets.only(left: 24.0),
      //       //     child: Icon(
      //       //       Icons.close,
      //       //       color: Colors.red,
      //       //       size: 30,
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 60,
        ),
        child: isLoading
            ? const SizedBox(
                height: 500,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}
