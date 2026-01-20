import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/student_provider.dart';

class ImageLoader extends StatefulWidget {
  final bool autoRefresh;

  const ImageLoader({Key? key, this.autoRefresh = false}) : super(key: key);

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

Future<void> loadImage(BuildContext context) async {
  print("call provider");
  Provider.of<StudentProvider>(context, listen: false).context = context;
  Provider.of<StudentProvider>(context, listen: false).refreshData();
}

Future<void> refreshData(BuildContext context) async {
  print("refresh");
  await loadImage(context);
}

class _ImageLoaderState extends State<ImageLoader> {
  Uint8List? imageData = Uint8List(0);
  bool _hasLoadedImage = false;

  @override
  void initState() {
    super.initState();
    // โหลดรูปอัตโนมัติเมื่อ widget ถูกสร้าง
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImageIfNeeded();
    });
  }

  void _loadImageIfNeeded() {
    if (!_hasLoadedImage) {
      final provider = Provider.of<StudentProvider>(context, listen: false);
      // ตรวจสอบว่ายังไม่มีรูป หรือ autoRefresh เปิดอยู่
      if (provider.imageData.isEmpty || widget.autoRefresh) {
        provider.context = context;
        provider.refreshData();
      }
      _hasLoadedImage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    imageData = context.watch<StudentProvider>().imageData;
    double screenWidth = MediaQuery.of(context).size.width;
    final double imageSize = screenWidth * 0.45;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppTheme.ru_yellow,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(96),
        child: imageData!.length > 0
            ? Image.memory(
                imageData!,
                scale: 1.25,
                fit: BoxFit.cover,
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.ru_dark_blue,
                      AppTheme.ru_dark_blue.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: Icon(
                          Icons.person,
                          size: imageSize * 0.7,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.ru_yellow.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.photo_camera,
                              size: 32,
                              color: AppTheme.ru_yellow,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Title
                          Text(
                            'ไม่พบรูปภาพ',
                            style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Message
                          Flexible(
                            child: SingleChildScrollView(
                              child: Text(
                                'โปรดติดต่อหน่วยบัตรประจำตัวนักศึกษา (ปริญญาตรี)\nโทร. 02-3108605',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 10,
                                  color: Colors.white.withValues(alpha: 0.9),
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
