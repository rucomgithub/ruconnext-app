import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';

class MasterImageLoader extends StatefulWidget {
  @override
  _MasterImageLoaderState createState() => _MasterImageLoaderState();
}

class _MasterImageLoaderState extends State<MasterImageLoader> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenProvider>(
      builder: (context, provider, _) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        double baseFontSize =
            screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
        if (provider.isLoading) {
          return SizedBox();
        } else {
          return SizedBox(
            width: screenWidth * 0.4,
            height: screenHeight * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: provider.profile.photoUrl.toString().length > 0
                  ? Image.network(
                      provider.profile
                          .photoUrl!, // Replace with your actual image URL
                      fit: BoxFit.cover, // Adjust the BoxFit as needed
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
                              fontSize: baseFontSize - 6,
                              color: AppTheme.nearlyWhite,
                            ),
                            'ปรับเปลี่ยนรูปภาพที่ บัญชี Gmail ของคุณ.'),
                      ),
                      alignment: Alignment.center,
                    ),
            ),
          );
        }
      },
    );
  }
}
