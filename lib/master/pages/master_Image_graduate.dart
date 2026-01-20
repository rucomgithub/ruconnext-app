import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_provider.dart';

class MasterImageGraduate extends StatefulWidget {
  @override
  _MasterImageGraduateState createState() => _MasterImageGraduateState();
}

Future<void> loadImage(BuildContext context) async {
  print("call provider");
  Provider.of<MasterProvider>(context, listen: false).refreshData();
}

Future<void> refreshData(BuildContext context) async {
  print("refresh");
  await loadImage(context);
}

class _MasterImageGraduateState extends State<MasterImageGraduate> {
  Uint8List? imageData = Uint8List(0);

  @override
  void initState() {
    super.initState();
    // เรียก refreshData หลัง build เสร็จเพื่อหลีกเลี่ยง error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MasterProvider>(context, listen: false).refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    imageData = context.watch<MasterProvider>().imageData;
    //print('image: ${imageData}');
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.ru_yellow,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(100),
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        Text(
                          'ไม่พบรูปภาพ',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Text(
                              'โปรดติดต่อหน่วยบัตรประจำตัวนักศึกษา (ปริญญาโทและเอก)\nโทร. 02-3108605',
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
                ),
              ),
      ),
    );
  }
}
