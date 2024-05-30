import 'package:flutter/material.dart';
import '../app_theme.dart';

class Rubar extends StatelessWidget {
  String textTitle;

  Rubar({required this.textTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$textTitle',
        style: TextStyle(
          fontFamily: AppTheme.ruFontKanit,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}
