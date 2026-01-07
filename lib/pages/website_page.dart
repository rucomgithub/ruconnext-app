import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsitePage extends StatefulWidget {
  const WebsitePage({super.key});

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  Map<String, dynamic> news = {};
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    news = Get.arguments;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('${news['url']}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${news['title']}')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
