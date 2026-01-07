import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class GradeHelpScreen extends StatelessWidget {
  const GradeHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'หน้าข้อมูลผลการเรียนทั้งหมด',
      imageUrls: const [
        'https://sevkn.ru.ac.th/rusmart/manual/12.png',
        'https://sevkn.ru.ac.th/rusmart/manual/13.png',
        'https://sevkn.ru.ac.th/rusmart/manual/14.png',
        'https://sevkn.ru.ac.th/rusmart/manual/15.png',
        'https://sevkn.ru.ac.th/rusmart/manual/16.png',
        'https://sevkn.ru.ac.th/rusmart/manual/17.png',
        'https://sevkn.ru.ac.th/rusmart/manual/18.png',
        'https://sevkn.ru.ac.th/rusmart/manual/19.png',
      ],
    );
  }
}
