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
        if (provider.isLoading) {
          return NotImage();
        } else {
          return SizedBox(
            width: 180,
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: provider.profile.photoUrl.toString().length > 0
                  ? Image.network(
                      provider.profile
                          .photoUrl!, // Replace with your actual image URL
                      fit: BoxFit.cover, // Adjust the BoxFit as needed
                    )
                  : NotImage(),
            ),
          );
        }
      },
    );
  }
}

class NotImage extends StatelessWidget {
  const NotImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 220,
      child: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              style: TextStyle(
                fontFamily: AppTheme.ruFontKanit,
                fontSize: 16,
                color: AppTheme.ru_text_grey,
              ),
              'ไม่พบรูปภาพ'),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
