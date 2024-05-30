import 'dart:async';

import 'package:th.ac.ru.uSmart/providers/runewsprovider.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/services/runewsservice.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

class RunewsdetailPage extends StatefulWidget {
  const RunewsdetailPage({super.key});

  @override
  State<RunewsdetailPage> createState() => _RunewsdetailPageState();
}

class _RunewsdetailPageState extends State<RunewsdetailPage> {
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
      appBar: AppBar(
        title: Text('${news['title']}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Provider.of<RunewsProvider>(context, listen: false).getAllRunews(),
            // Get.toNamed('/runews'),
            Get.back(),
            // Get.offAllNamed('/runews')
          },
        ),
      ),
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
