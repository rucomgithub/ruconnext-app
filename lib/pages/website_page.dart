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
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    news = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${news['title']}')),
      body: WebView(
        initialUrl: '${news['url']}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onPageFinished: (finish) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }
}
