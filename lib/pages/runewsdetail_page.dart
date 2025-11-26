import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/runewsprovider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RunewsdetailPage extends StatefulWidget {
  const RunewsdetailPage({super.key});

  @override
  State<RunewsdetailPage> createState() => _RunewsdetailPageState();
}

class _RunewsdetailPageState extends State<RunewsdetailPage> {
  Map<String, dynamic> news = {};
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // รับ arguments จาก Get.arguments
    news = Get.arguments ?? {};

    // สร้าง controller ใหม่
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(news['url'] ?? 'https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news['title'] ?? 'รายละเอียดข่าว'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<RunewsProvider>(context, listen: false).getAllRunews();
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
