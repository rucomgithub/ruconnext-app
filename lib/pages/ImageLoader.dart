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
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        double baseFontSize =
            screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
        return SizedBox(
          width: screenWidth * 0.4,
          height: screenHeight * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: provider.imageData.length > 0
                ? Image.memory(
                    provider.imageData,
                    scale: 1.25,
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: AppTheme.ru_dark_blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontSize: baseFontSize - 8,
                            color: AppTheme.nearlyWhite,
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
