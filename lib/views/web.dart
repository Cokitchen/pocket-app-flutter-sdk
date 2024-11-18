import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:pocket_app_flutter_sdk/raw/pocket_html.dart';

class Web extends StatefulWidget {
  const Web({
    Key? key,
    this.okraOptions,
    this.shortUrl,
    this.onSuccess,
    this.onError,
    this.onClose,
    this.beforeClose,
    this.onEvent,
  }) : super(key: key);

  final Map<String, dynamic>? okraOptions;
  final String? shortUrl;
  final Function(String data)? onSuccess;
  final Function(String message)? onError;
  final Function(String message)? onClose;
  final Function(String message)? beforeClose;
  final Function(String message)? onEvent;

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
      ..addJavaScriptChannel("FlutterBeforeClose",
          onMessageReceived: onFlutterBeforeClose)
      ..addJavaScriptChannel("FlutterOnEvent",
          onMessageReceived: onFlutterEvent)
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
      ..loadHtmlString(buildPocketWithOptions());
  }

  void onFlutterSuccess(JavaScriptMessage message) {
    if (widget.onSuccess != null) {
      widget.onSuccess!(message.message);
    }
  }

  void onFlutterError(JavaScriptMessage message) {
    if (widget.onError != null) {
      widget.onError!(jsonDecode(message.message)["data"]["error"].toString());
    }
  }

  void onFlutterClose(JavaScriptMessage message) {
    if (widget.onClose != null) {
      widget.onClose!(message.message);
    }
    Navigator.pop(context);
  }

  void onFlutterBeforeClose(JavaScriptMessage message) {
    if (widget.beforeClose != null) {
      widget.beforeClose!(message.message);
    }
  }

  void onFlutterEvent(JavaScriptMessage message) {
    if (widget.onEvent != null) {
      widget.onEvent!(message.message);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 38.0, left: 16, right: 16),
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(width: 0, height: 0, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
