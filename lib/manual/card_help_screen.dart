import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class CardHelpScreen extends StatelessWidget {
  const CardHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'หน้าบัตรนักศึกษา',
      imageUrls: const [
        'https://sevkn.ru.ac.th/rusmart/manual/6.png',
        'https://sevkn.ru.ac.th/rusmart/manual/7.png',
        'https://sevkn.ru.ac.th/rusmart/manual/8.png',
        'https://sevkn.ru.ac.th/rusmart/manual/9.png',
        'https://sevkn.ru.ac.th/rusmart/manual/10.png',
        'https://sevkn.ru.ac.th/rusmart/manual/11.png',
      ],
    );
  }
}
