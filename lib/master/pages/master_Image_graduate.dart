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
    // refreshData(context);
    Provider.of<MasterProvider>(context, listen: false).refreshData();
  }

  @override
  Widget build(BuildContext context) {
    imageData = context.watch<MasterProvider>().imageData;
    //print('image: ${imageData}');
    return Container(
      child: SizedBox(
        width: 200,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageData!.length > 0
              ? Image.memory(
                  imageData!,
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
                          fontSize: 12,
                          color: AppTheme.nearlyWhite,
                        ),
                        'รูปภาพไม่แสดง โปรดติดต่อ (ระดับปริญญาโทและเอก) หน่วยบัตรประจำตัวนักศึกษา โทร. 02-3108605'),
                  ),
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}
