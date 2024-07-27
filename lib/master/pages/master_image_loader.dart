import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';
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
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;
          return SizedBox(
            width: screenWidth * 0.4,
            height: screenHeight * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ID.png'),
            fit: BoxFit.cover,
            opacity: 0.08,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.ru_grey,
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.person,
            size: 100,
            color: AppTheme.nearlyBlack,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
