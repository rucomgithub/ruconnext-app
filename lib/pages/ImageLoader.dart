import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/student_provider.dart';

class ImageLoader extends StatefulWidget {
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
  Uint8List? imageData;
  double screenWidth = 180;
  double screenHeight = 220;

  @override
  void initState() {
    super.initState();
    // refreshData(context);
    Provider.of<StudentProvider>(context, listen: false).context = context;
    Provider.of<StudentProvider>(context, listen: false).refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, _) {
        //print('image: ${provider.imageData}');
        return SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: provider.imageData.length > 0
                ? Image.memory(
                    provider.imageData,
                    scale: 1.25,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontSize: 12,
                            color: AppTheme.ru_text_grey,
                          ),
                          'รูปภาพไม่แสดง โปรดติดต่อ (ระดับปริญญาตรี) หน่วยบัตรประจำตัวนักศึกษา โทร. 02-3108605'),
                    ),
                    alignment: Alignment.center,
                  ),
          ),
        );
      },
    );
  }
}
